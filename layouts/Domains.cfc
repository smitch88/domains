<cfcomponent displayname="Domain Layout" extends="Base">

<cffunction name="body" access="public" output="yes">
	
	#super.body()#
		
	<div id="main-content">
		
		<div class="container">
	
</cffunction>

<cffunction name="end" access="public" output="yes">
			
		</div>
		
	</div>

	<script>
		
		// Externalize this later if wanted
		
		function Domains(){
			
			this.$tabs = null;
			this.tabsObjects = {
				"listing": 0,
				"add": 1	
			};

		}

		Domains.prototype = {
		    
			constructor: Domains,
			
			_init: function()  {
				
				var currentTabIndex = "0";
				
        		this._initHandlers();
				
				this._styleButtons();
				
				this._initDialog();
				
				// Generate tab interface
				this.$tabs = $( "##mainTabs" );
								
				this.$tabs.tabs({

					activate : function ( e, ui ) {
						
			            currentTabIndex = ui.newTab.index().toString();
						
			            sessionStorage.setItem( 'tab-index', currentTabIndex );
						
			        },
		 					
					// Delayed load so you dont see unstyled list when page loads
					create: function(){
						
						$( this ).show();
					
						if (sessionStorage.getItem('tab-index') != null) {
							
							currentTabIndex = sessionStorage.getItem( 'tab-index' );
	
						    $( this ).tabs( 'option', 'active', currentTabIndex );
							
						}
							
					}
					
				});
				
    		},
			
			_initHandlers: function(){
				
				var self = this;
				
				$( document ).on( 'click.domains', '.sebHeader a', $.proxy( this._activateAddTab , this ) );				
				
				$( document ).on( 'click.domains', '.sebColumnLink-edit', function( e ){

					e.preventDefault();
					
					var $dialog = $( "##domain-edit-form" ),
						buttonHREF = $( e.currentTarget ).prop( "href" );
					
					$dialog.find( '##loader' ).load( buttonHREF );
					
					$dialog.dialog( "open" );
								
				});
				
			},
			
			_styleButtons: function(){
				
				$( 'input[type="submit"]' ).button();
					
			},
			
			_initDialog: function(){
				
				var self = this;
				
				// Just testing out some ajax dialoging with jquery ui
				$( "##domain-edit-form" ).dialog({
					
					autoOpen: false,
					height: 300,
					width: 350,
					modal: true,
	
					buttons: {
						
						"Save": function() {
							
							var $form = $( '##edit-form' ),
								domainId = $form.find( "input[name='domainId']" ).val()
								domainValue = $form.find( "input[name='domainName']" ).val();
	
							$.ajax({
								
								type: "POST",
								url: "../Domains/model/Domains.cfc?method=remoteUpdateDomain",
								data: { id: domainId, domainName: domainValue },
								dataType: 'json',
								success: function( data ){
									
									console.log( data );
									
								}								
								
							});
							
						},
						
						Cancel: function() {
							
							$( this ).dialog( "close" );
							
						}
						
					}
					
				});				
				
			},
			
			_activateAddTab: function( e ){
				 
				e.preventDefault();
				
				this.$tabs.tabs( "option", "active", this.tabsObjects[ "add" ] );
				
			}
								
		}
		
		$( function() {
			
			var domains = new Domains();
			
			domains._init();
			
		});
		
	</script>
	
	#super.end()#
	
</cffunction>

</cfcomponent>