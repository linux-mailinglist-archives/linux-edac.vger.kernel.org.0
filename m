Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C283D60C1E0
	for <lists+linux-edac@lfdr.de>; Tue, 25 Oct 2022 04:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiJYCqf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Oct 2022 22:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiJYCq1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Oct 2022 22:46:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695BF1BE92
        for <linux-edac@vger.kernel.org>; Mon, 24 Oct 2022 19:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666665986; x=1698201986;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=pYX9pzskYlwxHLSvoNRf4H47tedZt5ftKTaPFLvkFyE=;
  b=Cu3DD5JmKbtfQV1NJydngb6/grxERZvmXtPgBRP8D6XpyoEsBEV1d5SR
   5RXQTrbUVvKEpZ+f/vA2sapy1ImbZg8LyBERIDxdR6Wf8PkFUJZA6Sw4v
   KB4h+InNNDovZFOCX6TWSmQ977veJmZQjldMru2N19cgae+jhIAEnpfjL
   ag23huwmd6SDmxXT3anscZb2DryP+PdWfYk/FkaZhx1jCWzaYemtGtjmC
   zHw6pk9rgjhWlNw2eajS4/S4XC8dotq9qpAJL2iNbUxQvM3GGywLYkWPH
   lKawKUwondmk9OpvdiKDtTKuFX41OK4hRtslafxtLWlKLj0zDRwfzjMDy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="371788607"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="371788607"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 19:46:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="806513807"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="806513807"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 24 Oct 2022 19:46:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 19:46:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 19:46:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 19:46:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 19:46:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jipmx9SBpNQOtwNrqueyDTUEZuYOOJQ2vEjZPa+HCuiuZbDr6KKfdJI9762T9EU4MykvRe+s5e1vekQ72yieECCtXh22X+X8gi/j5ncSI0xuTQYJiUfn1+7gQStbtfhMYwYsp781cLzrkoYqCZjdt/q4JF5HE3cOeJBay92v6e5H+4y66CKzMMOQfKmheDCHNVzD8nOW0eHrQzLJIiXHADOZRlpjYSu0jaecr50Sgyje/+K9HB4qpBbK7xtFxGprU49g0ZcBtpXcfHnRB1GnGtp4RLdsH7ajLJJkDbyTv0PqdcMF/y3/Fl8pBsl0m0wtTYkRi7Gt5bde80sZZVlu/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYX9pzskYlwxHLSvoNRf4H47tedZt5ftKTaPFLvkFyE=;
 b=IIPvYdVRs95EGVa4qU1qKMzNEWJrN8JkqKbVmA9aJFGvzB10NWMNX4WmryOdNl9oi6FK5peUiciBu+aHz3aifgmtKXdVeC+jcY4zpyhtyEyaydHTYiFgffMzsjjULOkGT3P7C0hCwMYCSt+BvJQaXd0GrXwyyKXxvsynIirPPmm1Ctd5NLuZS2IS0XIdtnAVP40xxNJQ84sUCBUCV73XQaUdVe014wWanKWXtnEGp9peAp8LXyeSzm2TXd0G3Tgd9uLpJh1qHJNn8dkevdARymp6YnQlb52TW1r6JP2STam3JUWKf520APOGoHb7NSkOUeuadKpGYV3Ajf98w3X82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by SJ0PR11MB5664.namprd11.prod.outlook.com (2603:10b6:a03:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 02:46:24 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::f21b:ac04:aef5:2017]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::f21b:ac04:aef5:2017%4]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 02:46:24 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Orion Poplawski <orion@nwra.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: EDAC igen6 error messages at boot
Thread-Topic: EDAC igen6 error messages at boot
Thread-Index: AQHY5WeuDAdwH4Nwnk+1Shv6FHJ5fq4ebGxQ
Date:   Tue, 25 Oct 2022 02:46:23 +0000
Message-ID: <IA1PR11MB61719B0624357D88C44426E589319@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <11240651-e924-8d8b-c2f7-c6e031e6b95a@nwra.com>
In-Reply-To: <11240651-e924-8d8b-c2f7-c6e031e6b95a@nwra.com>
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
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|SJ0PR11MB5664:EE_
x-ms-office365-filtering-correlation-id: c13ff74d-203f-48bd-cf50-08dab6331b07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZsNYPL5UwW3wvbnnXCDX5SuJjRTLQXchce+JADUgi+yZI40djBLdgpgC35BM7kI5PTQ2UkRWikXJwFzfE9H2WOfGqfzWPoySCWoUB87ilN75HtSv+svNlDIm75bsb/yTeWibvCMayGguRAJxUeAu/yAbWkKEUOvU04kEZgQ+QzXeo7LEph0bYVHTZsOyZeO1Vj4ncDYDmrxrvmV4X1KA9k7DjXGhr658DxpJday06Jp33j7DcbhyUgyhxXIJkrKzUxxf+2DTYWkkMLHkUwLgCWpc7yjJt61ImUH1PJgRzfOpEKhXsWwWXN48A79kcnyOh1S9Ox8JdTNphHreI0lvQnF1pbIf9YECIBRuDA2LODT4n2dOCDgc5yC9RLPEYal6xRzSyrZoSaXKMFduGt3Y/q0Et8TbOv/1F95JdkuXHsimxcJ5iAmd93eCDkmYzzQ7Ca3OEdJPGqZEVTnxGoBthZ6Ng4Gs8m4k3o4zsIIhs0cddlUpUl6i9H+TC0rE/dnmsnYI4OMfl615QHjytxFuigo9j2Qfs6RIwLLfRUm8AV5UQu7YrgScrRW8FlVO8bEoktaIrJDflF1mP2L+xkKQ7EX+g9efdl616AV361wAyJ4DFfIwBGCc+P2WH5lySdxeBUwlYcVy5QEELCSnc7oJtCUuTxSfQCdDPkDdnn1KJixUlo/kA8cX1S8anS6EoA9jzP8t2qhf+TlGZQEZBI4n7DsYGt3l1qYtoRybFaE2trleYV0DUINf3aMzHnfkyKVPtnvj6GeBk4ZXEBy0UXeaaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199015)(33656002)(38070700005)(2906002)(15650500001)(5660300002)(8936002)(64756008)(8676002)(110136005)(66476007)(41300700001)(66946007)(52536014)(66556008)(86362001)(66446008)(316002)(6506007)(26005)(9686003)(76116006)(53546011)(7696005)(83380400001)(186003)(71200400001)(82960400001)(55016003)(38100700002)(122000001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEE4VG5zbUh0WTlMOE44Z2VHUUR4ekpHUjNWdVprL3Rob2NVSkVHWHVnRklw?=
 =?utf-8?B?c0lKTGRSRUxxVjV4bG55STAwY3RoTllyR0Z5MDliM0JKYWh0QkNkeGxmQS8w?=
 =?utf-8?B?M3pKTzAzK0lxdFduQkFraHBQZExJL3F2OVh2ZFFKKzV6UkNwOFg4TVAvNmJG?=
 =?utf-8?B?elIvZjkraElqZjVUc2FRd0ZFSVlhVng0WERHL2FneHdDalpta09KeTNOdlJT?=
 =?utf-8?B?YS9tMEdDZjJBZTZrWVRLMEJmRE11SVFWVEhkOEtHNHhrN2JLV2NYUVNtbEgr?=
 =?utf-8?B?MmpwSzUwRnpMYWpuR0pWUEZkaVY4RjRHbTNJSHpCSytOMHgwc1dsOFNLbTJn?=
 =?utf-8?B?NE5yaWNtYUtWRjRneWRCV2FiQmdTbGZkczU2SGpjMURqZ00vL21LRkFKUHho?=
 =?utf-8?B?bDlVTitKV2swVnlVTTdFa1ZPTFVuV3JoNEc3a2NkZDRPU3h3aU5rLzNGTHJy?=
 =?utf-8?B?dWhFMUVQQmtQTWhNdk15TENJby9zUjlFVGd0WGhUdk11RHI1V01XZGlBdTJh?=
 =?utf-8?B?NjBtRFdndFoxQUJpbXF3YnZTdUNqWm5lMzNBTHEzYVowSlBsRnV1RjRGcytU?=
 =?utf-8?B?TFBNV1UvRTM5dStzcWdZZU1hNzBJS0E2OWhaR05zeVB1TExMMWt1RlhkQVR5?=
 =?utf-8?B?Y2JnUU1zeWZra1dRK3RVNkVsdkhiM093bDF3YnQrazQrd2NBQjdOYmEyS3hv?=
 =?utf-8?B?WDM0aGJHdE9aWVF1ekc4NERjdHFYLzdyNzlkQ2JjcnE5b2g3YjlnMGFCOVk1?=
 =?utf-8?B?ZXFjMUdKK3Z1aG8vckNDeDRvTEJucjFrRnJiMXlvZGUrazVxTVR4OUU0Szl1?=
 =?utf-8?B?enZ3VSs0OG5TUzc4RVlGeFNxM00yekxhWE96Nk84QjhjYjVQU3ZYTVA3U0kz?=
 =?utf-8?B?aThFdUVXbTE5bFl0VmV2UGJKL3lBeUQreWhmM2d4NFBkeC85MSs4UTFZZGxG?=
 =?utf-8?B?U3M5d3ZlbkY2SEpLL1d0TndiU0tIWGdEbHJzVFJTc1BqUzg3SGVRSmF0SVBl?=
 =?utf-8?B?d2s3UUdCemNyUTR3bW1YLzdFSnRiNkcyb1kvTll5RVo1d3cxdmFsNnoycHla?=
 =?utf-8?B?SXd0enJkZGN3K1BpSG1abTNWMTNBeDZNeVMxMFFaUklmbThlZlNxbFFXaHJ6?=
 =?utf-8?B?VXErUzhnb1dxUkVFRXA3eEp3eGMzUmxDWFU4KzJma0xEZVpGdkIraW9Ub0lV?=
 =?utf-8?B?a1QzVGpTNzVwNGdPQW1IbUNPNFF2azMyZUtETy9qTWdtcEE0VGlUak5jNWhm?=
 =?utf-8?B?SGF0VVZabWtETUp6c0cvS2pTRHZLVUpEem0zVkhobzB0bXpLZS94NWpSWjNT?=
 =?utf-8?B?WkZNYmZRWjdKdFVEcklMYVUwM2F0cHV0c050SlhwektJbXpYK2hndDVuV1c1?=
 =?utf-8?B?dUM2bjB4RVE2SE9BekJtK0FnbnNtTFYzNG5KWm9oMTVyclIyV3dxQ2t6cjI0?=
 =?utf-8?B?aERWYWE1RGNUZjRSVzZaTUwzMXdTanc0bnY4SjhBUENTWVNZYW5TV0JNSWZ5?=
 =?utf-8?B?TzlITUs4RWxkZzhDMlJmclhoYkpiaEVyenBiRkZFK3R4YzV0VjJCeWlkZktX?=
 =?utf-8?B?WE5qeXI3N1JTTzdIMlBhZlZjeHFrb2ZraCt4STZJbDRJZUtDeWg4a1pNRUJH?=
 =?utf-8?B?amhwaWMwbElrbVBDZnRzRzJkb25aZHJ1ZnZlbE9lbFozN0ZVckE1NThJRDJ6?=
 =?utf-8?B?L3ZGSEhtcVFiYjMyUXF5Z1BWeVlNc2RhZEZUVUEreDFabHNkVWt0WHU1bklM?=
 =?utf-8?B?UU5ULytiV1k5dSt0TnRSNkRJN3RLdTJqS2x6V1lRaGRnTGp2OVFnRThqT3FX?=
 =?utf-8?B?TWVZeXZRUEdlclZFR2tHQnVmd3o3SUh3M1dqenZuVkRrOHUrSml0U2FJLzBD?=
 =?utf-8?B?S1Z2Um15Q0dmYTROVWJkVUwyREdBVzU2SlRYcnJzQ2lBZEFUZHA0ZEQ1ZTdU?=
 =?utf-8?B?emplcmdSNFBFYlRYakxvblh2VDJCc0VwMWVaSjl3c1RYNkhqalhQQ3RDM2Z6?=
 =?utf-8?B?Vi8ralRLTjVpNW5JaW5Gd2JUYks3MUd0SUk1RWhDL2QxWGE1YkdtUlZjZ0Yz?=
 =?utf-8?B?bzcwdE5FYnVWT2p0cFREYVdQT3czNzdEL0VRRXNjMDR6U2YyMythUFJURkhn?=
 =?utf-8?Q?007iZBnPOz7em8aMXZ4SfFigG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13ff74d-203f-48bd-cf50-08dab6331b07
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 02:46:23.9116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZS8PjUSrqbuOsab01VWvrOY97wJmvY7wkeDB5Iwt2oD6WdiFDQ6ocI/Ycl9XItYG5LELTolBkAw2cWx+zJBP6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5664
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

DQoNCj4gRnJvbTogT3Jpb24gUG9wbGF3c2tpIDxvcmlvbkBud3JhLmNvbT4NCj4gU2VudDogU2F0
dXJkYXksIE9jdG9iZXIgMjIsIDIwMjIgMTI6MDggQU0NCj4gVG86IGxpbnV4LWVkYWNAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IEVEQUMgaWdlbjYgZXJyb3IgbWVzc2FnZXMgYXQgYm9vdA0K
PiANCj4gV2UgaGF2ZSBhIERlbGwgWFBTIDE1IDk1MjAgcnVubmluZyA1LjE1LjAtNTItZ2VuZXJp
YyAoVWJ1bnR1IDIwLjA0KSBhbmQgZ2V0DQo+IHRoZSBmb2xsb3dpbmcgYXQgYm9vdDoNCj4gDQo+
IFsgICAgMC45ODE2NDFdIEVEQUMgTUM6IFZlcjogMy4wLjANCj4gWyAgIDMxLjgwMTEyNl0gY2Fs
bGVyIGlnZW42X3Byb2JlKzB4MTc2LzB4N2IwIFtpZ2VuNl9lZGFjXSBtYXBwaW5nIG11bHRpcGxl
DQo+IEJBUnMNCj4gWyAgIDMxLjgwNTI3Ml0gRURBQyBNQzA6IEdpdmluZyBvdXQgZGV2aWNlIHRv
IG1vZHVsZSBpZ2VuNl9lZGFjIGNvbnRyb2xsZXINCj4gSW50ZWxfY2xpZW50X1NvQyBNQyMwOiBE
RVYgMDAwMDowMDowMC4wIChJTlRFUlJVUFQpDQo+IFsgICAzMS44MTA1OTldIEVEQUMgTUMxOiBH
aXZpbmcgb3V0IGRldmljZSB0byBtb2R1bGUgaWdlbjZfZWRhYyBjb250cm9sbGVyDQo+IEludGVs
X2NsaWVudF9Tb0MgTUMjMTogREVWIDAwMDA6MDA6MDAuMCAoSU5URVJSVVBUKQ0KPiBbICAgMzEu
ODEwNjE2XSBFREFDIGlnZW42IE1DMTogSEFORExJTkcgSUJFQ0MgTUVNT1JZIEVSUk9SDQo+IFsg
ICAzMS44MTA2MTddIEVEQUMgaWdlbjYgTUMxOiBBRERSIDB4N2ZmZmZmZmZlMA0KPiBbICAgMzEu
ODEwNjE5XSBFREFDIGlnZW42IE1DMDogSEFORExJTkcgSUJFQ0MgTUVNT1JZIEVSUk9SDQo+IFsg
ICAzMS44MTA2MjBdIEVEQUMgaWdlbjYgTUMwOiBBRERSIDB4N2ZmZmZmZmZlMA0KDQpEaWQgeW91
IHN0aWxsIHNlZSB0aGUgZXJyb3IgbG9nIGFmdGVyIHlvdSByZS1ib290IHRoZSBtYWNoaW5lPw0K
DQo+IFsgICAzMS44MTE5NTddIEVEQUMgaWdlbjY6IHYyLjUNCj4gDQo+IGxvZ3dhdGNoIHRyaWdn
ZXJzIG9uIHRoZSBFUlJPUiBhbmQgcmVwb3J0cyB0aGVtLg0KPiANCj4gSG93ZXZlciwgZnJvbSBz
b21lIHNlYXJjaGluZyBhcm91bmQgdGhpcyBzZWVtcyB0byBiZSBmYWlybHkgY29tbW9uLCBzbyBJ
J20NCj4gZ3Vlc3NpbmcgdGhleSBhcmUgc29tZXdoYXQgc3B1cmlvdXMuICBVbmZvcnR1bmF0ZWx5
IHRoZSBtZXNzYWdlcyBzZWVtIHRvIGJlDQo+IHNpbWlsYXIgdG8gd2hhdCB5b3Ugd291bGQgc2Vl
IHdpdGggYW4gYWN0dWFsIG1lbW9yeSBlcnJvciBzbyBkb24ndCB3YW50IHRvDQo+IGNvbXBsZXRl
bHkgaWdub3JlIHRoZW0uDQo+IA0KPiBDb3VsZCBhbnlvbmUgc2hlZCBzb21lIG1vcmUgbGlnaHQg
aGVyZT8NCj4gDQo+IFRoYW5rcyENCj4gDQoNCg==
