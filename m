Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881D774AB33
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jul 2023 08:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjGGGiQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Jul 2023 02:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjGGGiP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 7 Jul 2023 02:38:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573EF1FC9;
        Thu,  6 Jul 2023 23:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688711894; x=1720247894;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=An7YBSOFOHs+PzZGWpP9wt/5lHvCLteChq7HlMK//E0=;
  b=kj8CwjLAYdgUjVQC33gxbc04iRIpKStK1w9p8e5t7380DQISVNYDbrE9
   E0pq5Zprmwfv6S87+uhv2a8xqdqyD3bKivYc87HTlKaDCR802TfjjUWbA
   n2tgKDhLxC+i5nthOjj2WaYWlHpqTdm/CkSfCKPH6GY810a/kPywgdLPt
   4jHVv5tDIxRSBr+10eTUvjJkkmVyTQsUW59sl1uBNntKYydBbmcBqYWcR
   BKgVEQ6g6QIx6ec1OXY7tiR5lUiq00IfN0lN4HC9ZBWSW7mkg3KzX+Kiv
   PF77LO1JJ2lsjuQ/eIvn2UKOJozeDYo15UK/b29Xzxf05USPUZ1FB5e/T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="427500122"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="427500122"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 23:38:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="893855215"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="893855215"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 06 Jul 2023 23:38:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 23:38:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 23:38:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 23:38:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5dn1oq6nCxnw/fjpTO9XU0pFORpHmo2CaCfDTvCu8XKyieTqKGY5ymRs7KEWj2hV1v1BafRnCD8C1ISq+DAGGIqxH5HQxzkKQdqWrK7I0Iyt5dzX8DG0YFDBJPU2GUB38mXogXh+wMUap4RL5WQAD12eC/uCVeAMnX0warqVVcMxHRaRyJp+qgtbk8STpfDJPw9nNy7gCKmpXTqIPOPbNYdIwamCELWDeDj8zBm3HSqOFh8UyjGSfZsGAy3Y2TBx+jwglew71r6FLWJ0xKPNxyC5dCvHfxvhbooJ+LxHfgkf8/EBUVUFzYGjgsEmor620jcDKz+X1eGXtNosD/iPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=An7YBSOFOHs+PzZGWpP9wt/5lHvCLteChq7HlMK//E0=;
 b=IxsNG4HsvU80x6aY8/VvRxLU8oHJDiLj1STWpv+ht5mgxuOeV3lJpF99H1VzmNWa6TKxpKOtgG5fzhbn+2dvuFuK8N+XyBv+9CGqXz9cyb8uIadT4bbT/v0ysI3CfXXsaCA4GvxEeDbPV1BzX30MDJlN52eWp4K7gCunStdwP41Rm3H/mZZAsXMqLHEqOoTE0Ga68tWNUzg+RRO9phKEAS7pYW9/20ECD+8OEHD4fz7GK59+sEXEQkiSjqUBPuZz6KGTRqxfr4KwUvMavC5Uim7eb1W/Varn82oBnlFUGXaOykdKgvnpZ92xJ4M4CgSZ9WzMpnQMc+a2vaEXk+Kn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CO1PR11MB5170.namprd11.prod.outlook.com (2603:10b6:303:91::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 06:38:05 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::221f:dbc7:48ea:7df3]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::221f:dbc7:48ea:7df3%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 06:38:05 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
CC:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Koba Ko <koba.ko@canonical.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] EDAC/i10nm: Skip the absent memory controllers
Thread-Topic: [PATCH 1/1] EDAC/i10nm: Skip the absent memory controllers
Thread-Index: AQHZsBBWZewp9aBWqE6u79trmsLb56+tyBuAgAASGNA=
Date:   Fri, 7 Jul 2023 06:38:05 +0000
Message-ID: <CY8PR11MB71343D8C5C1AEEB1604FCFEB892DA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20230706134216.37044-1-qiuxu.zhuo@intel.com>
 <CAAd53p6J8usSi+rHnd9+714mUqZ2zTdhFSEWUtiK7aNzcAZ8CA@mail.gmail.com>
In-Reply-To: <CAAd53p6J8usSi+rHnd9+714mUqZ2zTdhFSEWUtiK7aNzcAZ8CA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CO1PR11MB5170:EE_
x-ms-office365-filtering-correlation-id: 15b3a349-b5e1-47dc-3d7f-08db7eb4b854
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 98oYyqtCG6z4Y4XKaT3+n9erWFkz5G9JY5eTieQYX9pNb5gyuRHQ111affp2oOi7csOyUMPCw7We4MfpNY4xyr9kM7DKhEzCBdVXNU0BJo97Q+1yVQ2+9qkaPQ7MWWWxDbrJAd5nXnPqkgDT4GcU7KnH3Jy/tKD5xNHzLu+ODLmeNBbgBeQQ4LRqUWER0zXPNVWCD5dPG7G0PKtZTl47KAq4fi7LYNxh2K6it4RsVerybxOAn5Nq0gLmX+yCica3rpxlcRuywthVtg+haioTVcviqdhIu84KYLFBrainbrEZJIsph+GzBaOYc4VPSy/juiqnzSJve0rorPv4ZQdXBPYuQGxZW3IcY6pzQU9pnwkzCLv72bJuSu8vn4afE8cBBEff1EVilq4MHJmghaF582HetOIg2uyUwcB7Rg3tjt3NNs99hed97N2PEKcacaBbR1heNntATAhg9bIYL+LiOweSIBvM8xN+/HrrC09HAzaE12GwpJfGLV5CEfU3qy9xiv9CXLY9xtDdc76hrdAVDd4nCrNeJchUrzd3O58qGTTbCwetgKAFJ7Jl0/011RIhjKnFU6JF8d9i1DtPRCnU5TwIh91pqtcyS898Ot4wolU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199021)(82960400001)(122000001)(33656002)(86362001)(38070700005)(38100700002)(55016003)(54906003)(71200400001)(7696005)(8676002)(41300700001)(478600001)(9686003)(8936002)(5660300002)(52536014)(64756008)(66446008)(316002)(2906002)(66556008)(4326008)(76116006)(66946007)(66476007)(6916009)(4744005)(186003)(53546011)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejZJUzZMcFphT1JWaEk0WHVva001SWl2T1gzU2UvRnoxNWxkbHJZaVd2Vmxm?=
 =?utf-8?B?UXVSNlB1OW85MDBjaVhJL2dXRTdvNEJXUksxSm9mM1ZZa1FsODYxY2c5VStr?=
 =?utf-8?B?ZlBMbmZzeTFLOFArUENZZStkcngybGNOanpNT204ZE0vdFowS0tqN2NYTE9l?=
 =?utf-8?B?enBMQ1hCNjhCcmpnZUYyZkMrQkp4MFlUV2c4TG83YmZQYU5zZHFFZWc5eW0z?=
 =?utf-8?B?WHlobFlncDMxR0c4OS9oQ21UMklrdWl1VHNxL0xRRUIyMWZVcStzdllXdHNO?=
 =?utf-8?B?dG1zbVdaZytCSVhTbUdIeHE1MWRFWHNUUTh4NE9hMEdDem1JeWZsK3AxakZE?=
 =?utf-8?B?aFUxazFPeWg0ZE9tNTdtL1dEbURQQzBZMStFeGN5K2c0V3NSTzg4anJINHJq?=
 =?utf-8?B?MDdTRTBWYXl4eUk0OVZqUFFnN29reENsN3RDM0s0MXZjdW1vamNEeFBZd0dh?=
 =?utf-8?B?WnhRWWNsVDlzNmZLN1BvMHhsVWFRQ1AwN0lyNURJUFh3Umo2VHJ5WUxuRis4?=
 =?utf-8?B?MFJnU040dmJ0Tm1nTThuMFlZRWQwZFF5Szd4WlR3L2h0cm5ab1FJcjhKWWZM?=
 =?utf-8?B?Y3BiS1JVaWZJalViamlObU1yWEg3dHQ2cFV1L3BkS0ViV2VnYUgvZVBzWDh0?=
 =?utf-8?B?NUhCUE5Gd3hJOFk5QjJRWnlDdW5VREdVcHFwaFFBOGNFbEUreWpHQ0p4WUZN?=
 =?utf-8?B?MHRaTkpMQTdyRGs3dFhHREhwa0NqdDVUQ3Z6NVB0YThRckVlQVJVYW5sRHMw?=
 =?utf-8?B?ampDc3lmQ1ZsWExzVFhud3JLUlFBSnpWLzlPME45QjV2MnpEZlQzY0lkTDho?=
 =?utf-8?B?WWlRMUFJU25WWHlWalFnYkpyTHBpTHFrQU11V01wNzA4c0kzU2ZOYnIrRlRV?=
 =?utf-8?B?Y3Z6aXJLWmlHWTl4SGx0U0tHMHRQL1F5RWNwVFBKeGlmY3NLeDJYdjk3bUtC?=
 =?utf-8?B?RnFDSXVFWDUrcFN5eG4rMEIyaGFMN2VoTy9kQlUvN3lIdFR4NmZtR21Td09N?=
 =?utf-8?B?R2FDOWlqb0N2c1JmcUl3bmRyS2ZkUkdha1l5RWV0SkxQNHhVRk12c2U5eSt6?=
 =?utf-8?B?cjVyVnN0dys2c0hBT2xpUHl3V1JETi9aOXVDYTcwVHhUM0lHK09XUGYwTTFo?=
 =?utf-8?B?UjRCbW9aZmJNR3VMMXFvcmtGOXlYV3ZuZldLNHVBOExuai9SblUvbUZ6SHBU?=
 =?utf-8?B?OSt5eXFvcmhGcld1aTZpZGwrR2dQWEZ0Tnc1RUlCT0J4VnVsOWNIR2lVYWwv?=
 =?utf-8?B?Y2MweGNPOXRYUWxFMzI2Sy83UFVKVThvVVhiODZ1ckxnUDdMRk54YityQU1D?=
 =?utf-8?B?ZDY4YlRUM0EwaWtQTFQyM3ZHU3d4YWZsWG51R0EyOHdGTUVDRTlodk1BNlhl?=
 =?utf-8?B?ejdaKzkwaGovN2Z3L3BPUUNBK1dES1pmTzZ1OUU2MEdsMzdoUS8rZVJ4SVN2?=
 =?utf-8?B?cHNneXNBc3paRzZlSURXRi9HV0JEd3pzcDFSVnV3MWNnc0pVbjh6R3VXNGx2?=
 =?utf-8?B?eTN5K1A5NVRzYU9uYmtiZUlPYU1XWUVUVi91NjY5OXpZZ2JKQjI0Q2UxeUpO?=
 =?utf-8?B?MEhIR2loZHhLamJ0djBoMHB0ZFp0TTQxblV4LzUzZ0ZRVkhXNjhQUzE0Vkhl?=
 =?utf-8?B?L1JqMTdyNjA1QmF3UDE2V2VoVE80Um1ZNGRob2Y0a0dpT2dDOG5MK0Z2YzYx?=
 =?utf-8?B?a0FVdmhENlVDVVg4bDA4dWpObmx2NFgvcmM2MkZqTE93RHJVa2NRczhEYWFR?=
 =?utf-8?B?bHA4d3o3Ukt6WVpmMEVMZTJ2bUNEZFluSlFTWGFZb0M4cmNaWGNoTVZWSEZo?=
 =?utf-8?B?OGJSVUs0Qk40YWtHL2pITXpkYXUyVm9CNXJuWHBqZ3dyMUJsVU90MFV2WWhj?=
 =?utf-8?B?VjdFczJieEMvb1RuNWhXSCtETnlyM0pQa2N1TmFBL0pNQU9RaTNOQURxWHIx?=
 =?utf-8?B?Ty9DbFZYYU5SRnltMy9oczJkNEw0bDYvdllLemlidVlJL2U3dzJ3SjFzcnB0?=
 =?utf-8?B?TyszeWVINXFMSDlDNWsydXlvSDhKS0RWcHBVRUdkdlRuamQxa1A2eUhyNE5Q?=
 =?utf-8?B?eWRrS1RPT1RSYUgrK1grdEFiWkdBMmkzbGg2ck9qUXMvZ0R1UFRXdGpiZkV6?=
 =?utf-8?Q?9iVXTTDictbMMF4sMjlfxTTZX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b3a349-b5e1-47dc-3d7f-08db7eb4b854
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 06:38:05.4393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BEzF2TnnmBjkx068SmnZ5zSBaXsVj7iZI1U9eJIPvfhjiUq2vuwEqlUrrOnzVZR/mMFCs2o7QKVli6JSibym0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5170
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBGcm9tOiBLYWktSGVuZyBGZW5nIDxrYWkuaGVuZy5mZW5nQGNhbm9uaWNhbC5jb20+DQo+IC4u
Lg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gRURBQy9pMTBubTogU2tpcCB0aGUgYWJzZW50
IG1lbW9yeSBjb250cm9sbGVycw0KPiANCj4gT24gVGh1LCBKdWwgNiwgMjAyMyBhdCA5OjQ24oCv
UE0gUWl1eHUgWmh1byA8cWl1eHUuemh1b0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gU29t
ZSBTYXBwaGlyZSBSYXBpZHMgd29ya3N0YXRpb25zJyBhYnNlbnQgbWVtb3J5IGNvbnRyb2xsZXJz
IHN0aWxsDQo+ID4gYXBwZWFyIGFzIFBDSWUgZGV2aWNlcyB0aGF0IGZvb2wgdGhlIGkxMG5tX2Vk
YWMgZHJpdmVyIGFuZCByZXN1bHQgaW4NCj4gPiAic2hpZnQgZXhwb25ldCAtNjYgaXMgbmVnYXRp
dmUiIGNhbGwgdHJhY2VzIGZyb20gc2t4X2dldF9kaW1tX2luZm8oKS4NCj4gPg0KPiA+IFNraXAg
dGhlIGFic2VudCBtZW1vcnkgY29udHJvbGxlcnMgdG8gYXZvaWQgdGhlIGNhbGwgdHJhY2VzLg0K
PiA+DQo+ID4gUmVwb3J0ZWQtYnk6IEthaS1IZW5nIEZlbmcgPGthaS5oZW5nLmZlbmdAY2Fub25p
Y2FsLmNvbT4NCj4gLi4uDQo+IFRlc3RlZC1ieTogS2FpLUhlbmcgRmVuZyA8a2FpLmhlbmcuZmVu
Z0BjYW5vbmljYWwuY29tPg0KDQpUaGFua3MgZm9yIHRoZSB0ZXN0aW5nIGZlZWRiYWNrLg0KDQot
UWl1eHUNCg==
