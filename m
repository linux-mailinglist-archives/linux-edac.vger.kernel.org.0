Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EB9618FCF
	for <lists+linux-edac@lfdr.de>; Fri,  4 Nov 2022 06:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiKDFHT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Nov 2022 01:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKDFHS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 4 Nov 2022 01:07:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8469B27DC4
        for <linux-edac@vger.kernel.org>; Thu,  3 Nov 2022 22:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667538436; x=1699074436;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=s8vCausp4RiAKId3sUhe7zJ+dGaUaQIRlRKJHCPXL+c=;
  b=BYUTI2F5Itqzd3owWwN1skrXNFZa7wbdvlLzadY4Stkz+x0sfO2RxrVH
   fBxb8Hd/v1Hec4IFfIgxbcS4uwOoISm7WVRXgUkiZDLJxf9fdUQYB/NOw
   69w2Uj/ruoGyRakHXuYOwT7KHfJsS2aP5+UE7lDdRQOwn4AxXNw9GlZDX
   c+NbmyNLaCuqFoXfscKTbGIOMYIhvAAY3rlyQHNahC3FXtxW9oinC6bgB
   LwFxhKh0jNo9Qcpg8Ld2Ft6fWfNsfbkhOTG/gnX8QmsE019fZKi01RPYt
   r97tLq6srDqQvYYUDBX6wxMUdgTea5DGoDVCHDNZ8VOH+1LUszHHDMTFP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="371988809"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="371988809"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 22:07:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="637458173"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="637458173"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 03 Nov 2022 22:07:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 22:07:15 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 22:07:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 22:07:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 22:07:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=av/gfx2ba1Na0js/01pmPn5+T3PwgP8YO6H+hVXdO6txgqQfTwiPnciooKVq2iJpyl2YzcD1gteUt3FIzTesGNVni1Svwkpvx7nwQsY9j5WD6ZNXqDhgLPAfu72jMWWA9M4HwGcyFcYMFDBpxWGeSUrq0bu8ngZ3QJXObMJ2WwJOy5N7imZCXsQQMrDdiLc83XSVMWVqa3TUmJ5nPofcc3wE3Y1nhfukEnhFCYw7ajzRfyQsKCkR18QY7lZlefwX9brovFWN9iE4n2IhVwH7xkrjKQEDSrkSpL+RPNd5NdO4GDCe3WiQYRHsRBDeDWG4lqtnmSe2v7G3udMqX5ZQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8vCausp4RiAKId3sUhe7zJ+dGaUaQIRlRKJHCPXL+c=;
 b=QzYGcVg7+AG4iXPMM8VSYHDF+DdVzdGcc8JEOTbTFM4zkvM6en20QEqMl+hqmXV30SWGsYCt5sCk8tRyRNwBkNQFsN0Oq/EA2CUdCzg5h7/djVArr791S/JE9TU+eMEC/Yl69UebwX0uCvMpRmYKk8Cz5pmj33vrWDhiKAsp/RKSJb5ZKlIOEQU3znyjGIoBcVv9N5YP2bTjUYkHPe+phDki1zX6wddg5yY0LOVDRrW70svjm0psM5hdLObunGJrwoPki5nmjFiZNrun79ERHok214l9ZIg7NJFyEPW6O7nUQV10wILnV5035kBSBrmRREbHTfCzT/lU2SIb3p1m/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by SJ0PR11MB5584.namprd11.prod.outlook.com (2603:10b6:a03:3ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Fri, 4 Nov
 2022 05:07:13 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::ded1:9a40:d8b1:6194]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::ded1:9a40:d8b1:6194%7]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 05:07:13 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Orion Poplawski <orion@nwra.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: EDAC igen6 error messages at boot
Thread-Topic: EDAC igen6 error messages at boot
Thread-Index: AQHY5WeuDAdwH4Nwnk+1Shv6FHJ5fq4ebGxQgAAEN4CAAALJYIAAzrsAgADwLNCAC5PFgIACg6bg
Date:   Fri, 4 Nov 2022 05:07:13 +0000
Message-ID: <IA1PR11MB6171186E46E5DD584B8EDF64893B9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <11240651-e924-8d8b-c2f7-c6e031e6b95a@nwra.com>
 <IA1PR11MB61719B0624357D88C44426E589319@IA1PR11MB6171.namprd11.prod.outlook.com>
 <1233d52b-37f1-1629-1bca-162b72da22cb@nwra.com>
 <IA1PR11MB61715701ED05952113AEF26389319@IA1PR11MB6171.namprd11.prod.outlook.com>
 <46771e87-ba19-164b-a708-87165652fa07@nwra.com>
 <IA1PR11MB617155E9BCA54DED8687209189309@IA1PR11MB6171.namprd11.prod.outlook.com>
 <5f78ed98-e216-6202-8499-dbc7e4358cc5@nwra.com>
In-Reply-To: <5f78ed98-e216-6202-8499-dbc7e4358cc5@nwra.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|SJ0PR11MB5584:EE_
x-ms-office365-filtering-correlation-id: 2d9914c2-e1ff-47f3-674a-08dabe226f47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Al1IKhJA07C1yaVWeZ21EnSY5l7GPfjiSOYxUWlHTmcCsYyIF5XDPIzD80Zc9Q40NgISdC8T/aaa6Cg4Hz5Cza2a4aUmsZ38VSGvKh8eH13m2yQ9b+PiMJcKmoZk7PD0hN7Jhh9A5dVGT8lE/ypeuN7z0bsaLm5Xykq/pGPnQDCsaAYL8oUq/zgxqh6NyMiloVSXBYFcahUuV6bsjAYWtj1VSaKhbFOCmq8HUL8YRTw4h+PsR2yeHpP7VqA8EE7db9TWdVp2cV7MkcFF+BbvsmIw98nbfWNKWLTSCa5dl+Uaz5tQs3gP1JgZHKXOwCVgHbDfei7xSrOoxfpcKKVb7zeneLxCCMTTcwQYp5bacVxed1HFc++WPKninR3pPhmRxPVJvpkPOaSeEj0PTcpQT+Loi0XPRRqLO2Jr7Ag3GqVUJTihWIry1UNpUJo+wDLpN4587Ct71Q13SFnfn+V59dkxIWSihHFxGZ3fvPkgUiQrS0zXoAf2i7d5hcepD0dGWzAEs2nSytTjd0tC+mGJ6CLow8NKN9dxrfU8d9QFxC/S4Tm/e8aWakN3JT3rSHu5Zhd8qw4pxB0YZYCPgvz/705P63eYWrNYDgL8x2ZwsPMP8z2pPUE5s2GhqIsB/Xh0Y2ilNbsiD2pdG7P4PYcB/vDQBcbzH0EmmDidLnfTqwM6DWuUgMvy6BytW1cbu9Ew9ny7DuwGG2Vqbz0xw5CWf9ORLUGk+UMZSxRsJA3akJflSvWGhnl2vA9P6YgmmZqvyliKt75vmSDmF933b0x3Fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199015)(33656002)(38070700005)(55016003)(86362001)(122000001)(316002)(82960400001)(38100700002)(8676002)(7696005)(6506007)(71200400001)(66946007)(76116006)(478600001)(66446008)(41300700001)(110136005)(66476007)(64756008)(2906002)(4744005)(5660300002)(186003)(26005)(8936002)(83380400001)(9686003)(66556008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bCszYVltamkxTms2YmU5bklEd2g5S1JINGpyeFdGNG5CbS9CckNUdHYxOGVE?=
 =?utf-8?B?WGxxOTlvaXU5bFdxOHorVmlVYXJKOWlGUkxWZFY4Q1IwSVdYRG5xTWx6RzV6?=
 =?utf-8?B?b0ZseExRdVpubkdGU3AwbHN0M1JJc21YUkM0bkFicE5WWnA4L0dBd3ZEZXFx?=
 =?utf-8?B?VHFHS0M0RVFJT0xwM3d3c1dwTEVUNXV1aXE3TmRnWmJua20yTW1pMUU1VFY0?=
 =?utf-8?B?UDd1cTYxaEJ0VExCWUYrNEZyZWNYMUJacFZNcFlrT2NlMlhyNFZDdUJJajBY?=
 =?utf-8?B?Y3hGcVNXMlcvZlNUN0ZqUXdZZlVGdGprRWhLRklPUVdtUyswZkdhNG5oMGli?=
 =?utf-8?B?VHgwcE93TG9oSFdVQlg3MkFBdU80TU50dEpNeCtsUUx1c1lsZFVrY0NxZFZV?=
 =?utf-8?B?amxBQ3F2YXc3M0NvdXFQUHZxbDJIaGhXVTZ3QzgwOFNlUXBnYXJVTkFLY01C?=
 =?utf-8?B?STJnY3pzU3ZQYU9LY3BocUJLd3lRQk5IaDFyN2xwRStJc0tVaWU2TDhaTUhV?=
 =?utf-8?B?WFJBUjV2bkxtcVhka3RLaTNBK2ZudGR3VklOeHgxNlZlb0psNC9SaWt5dmNU?=
 =?utf-8?B?T2J4MHN6aVZsVGF1a3YxRCtWUXMwL244SC9oT2YrVkJLNDhVWnM0M0ovT3ZU?=
 =?utf-8?B?RnZ2WDJLNkliTXBsNzhmTjJSUk53TDl1QTFQN1krTmJaYk82R0dVakVtYlIy?=
 =?utf-8?B?N0VYY3hHN0R5WmpGSzlwamJIUUU3SUIrbVpHc2xjcVMvUjE0RVhhdDNMaWxO?=
 =?utf-8?B?Y0l5TWhJVmh5SGtWZlJtNnRQS1YxZEE5WnROdFk3c3J6Y0FERk9GOUhEbG9E?=
 =?utf-8?B?RU9aYTZQNzZaYVVwYzVMQ2lpajIybE1rQUFlcWM5SC94S08zbDF6NU0zeXha?=
 =?utf-8?B?cFpEeWhWWVd1WXJsNHlJOWpldHF3Sjh1S21qZnA3MFIwTzNxOUJNaWVIbFhZ?=
 =?utf-8?B?cVg5NWNsT0h4K21UaXNhU2MvYVVnUm1OcUxldVJwS0tkaEp3SkQwais0REVE?=
 =?utf-8?B?TXlMZ1FvYUU3elNrbU5tWEhNSXU5QjZrd0JWYm9kWnByQk54V0w4L2xMOTFm?=
 =?utf-8?B?UWU5dEJYOTEvRWprcGZrQWFjTFRXYnVUK2NPVmFZQmlldHFzbDNvZkx0aFVu?=
 =?utf-8?B?RGdtRURzc0dQSGxPUlJpeFhqNjUveHdOT0Y4K1g4RldUdk00VnovcFJFc0tP?=
 =?utf-8?B?NHNoSEVQbnlaUEsrdWNCdTZQSC9xa2xWYmkvNzB1Q1czZGw1Ulhpa04yWkhH?=
 =?utf-8?B?bW1oSklwekQ4dnRiZmJuRHg3NVJ4TUd2SjdodWdQU0dhSFluMzA3SlNGY3B1?=
 =?utf-8?B?RlV6Q1pQQzEzNHJ3YzhCN0xJZlI1UlFxcGZlaW5VM1BZV3IxaElreWUrZTQ3?=
 =?utf-8?B?RW5kOUFteXJhc09UZGF2YlN6aWZub2pVK0M2bCsvbHpRVXZkTnpYSVk0QUYr?=
 =?utf-8?B?SmdFcDJMZHFrYVF3ajA2cTlzTERkTkJJdUg0RUlKTk13MVFmQkxZeGRmNWdC?=
 =?utf-8?B?bEJtVDNxeWcyZzFHeG9tamtFTm5aVndqdHpSU0Izb3hTVjVVSmNYWjVaWCsy?=
 =?utf-8?B?OU55TmFvRzBCQUtWS29CZXBFNEN4ZzN3ZmhwUXJEbFF6REwvdzdpd3NYZ2dr?=
 =?utf-8?B?dDVqTVRBNEtLK2NlSlA5cjFidEpySVhQZkx6ZXltKzA5V1RMaTI0SWNlT21K?=
 =?utf-8?B?V2RObW9rTURTZG1SeEU4NzU2ZUV3Ym9NNjdJbXJDbzNWMmo1VWZCTktoZTgr?=
 =?utf-8?B?Q21oVTlPbVpQbWQxQTZvVFRpK2JlZ0FLcTFLTFpGd2dWQ01iWEIxdTlzUUln?=
 =?utf-8?B?THhxMVpuVHA5dTNJTTJ3R1lhK3Jkckp1RG4xQmNUKy9XNXYyVnViNDd4b1Av?=
 =?utf-8?B?WjNnL045b1ZJN0dqS0Zxb2ZPYkFjYUNUcmttR01zcmNWYVlBMGJ6K1BGTnl2?=
 =?utf-8?B?UUkrOW5jVHpjcXdtSko0Q1hacDZhM3YxRVFsckVCS094WWcxVDlzdlhmQUQv?=
 =?utf-8?B?UERnbzVXVWpFczNJRGFZRGUwTTlpQzZFVThKZDlHL0w4UTlCQVZMcmRQb0Jr?=
 =?utf-8?B?VWFvMkdBOGVnaFF4eC9uaDZDZDRXTStrSGtKamNoaTRRYVlkeHBST1ZmQisw?=
 =?utf-8?Q?r16P3sLVpc0Ooq8b9kpcus2tk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9914c2-e1ff-47f3-674a-08dabe226f47
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 05:07:13.1305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z/neBjmCea80AlE4LEEOG19OfwX3ECgSFViajHlG2qZSO6PEijTpAob++tWpPk9H1/cv55hkbzkz/Uz1KRnMqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5584
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBGcm9tOiBPcmlvbiBQb3BsYXdza2kgPG9yaW9uQG53cmEuY29tPg0KPiAuLi4NCj4gDQo+IEkg
Y2FuIGNvbmZpcm0gdGhhdCB0aGUgcGF0Y2ggcmVtb3ZlcyB0aGUgZXJyb3JzIGZyb20gdGhlIGxv
ZzoNCg0KVGhhbmtzIGZvciB0aGUgY29uZmlybWF0aW9uLg0KDQo+ICMgZG1lc2cgfCBncmVwIC1G
aSBlZGFjDQo+IFsgICAgMC45Nzk0OTddIEVEQUMgTUM6IFZlcjogMy4wLjANCj4gWyAgNDE3LjUz
ODgyM10gY2FsbGVyIGlnZW42X3Byb2JlKzB4MTc2LzB4N2IwIFtpZ2VuNl9lZGFjXSBtYXBwaW5n
DQo+IG11bHRpcGxlIEJBUnMNCj4gWyAgNDE3LjUzODg3Nl0gRURBQyBNQzA6IEdpdmluZyBvdXQg
ZGV2aWNlIHRvIG1vZHVsZSBpZ2VuNl9lZGFjDQo+IGNvbnRyb2xsZXIgSW50ZWxfY2xpZW50X1Nv
QyBNQyMwOiBERVYgMDAwMDowMDowMC4wIChJTlRFUlJVUFQpDQo+IFsgIDQxNy41NDE1OTddIEVE
QUMgTUMxOiBHaXZpbmcgb3V0IGRldmljZSB0byBtb2R1bGUgaWdlbjZfZWRhYw0KPiBjb250cm9s
bGVyIEludGVsX2NsaWVudF9Tb0MgTUMjMTogREVWIDAwMDA6MDA6MDAuMCAoSU5URVJSVVBUKQ0K
PiBbICA0MTcuNTQyMTg2XSBFREFDIGlnZW42OiB2Mi41DQo+IA0KPiBIb3dldmVyLCBJIGZvcmdv
dCB0byBlbmFibGUgdGhlIENPTkZJR19FREFDX0RFQlVHIG9wdGlvbiAtIGRvIHlvdSBzdGlsbA0K
PiBuZWVkIHRoYXQgb3V0cHV0Pw0KDQpOby4gDQpZb3VyIGNvbmZpcm1hdGlvbiBhYm92ZSB3YXMg
ZW5vdWdoLiDwn5iKDQoNCi1RaXV4dQ0K
