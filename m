Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1367965C8A7
	for <lists+linux-edac@lfdr.de>; Tue,  3 Jan 2023 22:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjACVMN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Jan 2023 16:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbjACVMH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 Jan 2023 16:12:07 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CEB1401C;
        Tue,  3 Jan 2023 13:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672780326; x=1704316326;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uWwyLsG1BJVU98RtkNacC6nnJi0N+PKV3cJiXuAEBCw=;
  b=Z+igQZKWR6qyCbn2UaiqHqJ475VAhs+qIaupentg8Zz7UlBTeX8dZjnB
   vIKpvD/QrxBbK5Ep0APHyxUZb5oFfePxdYnjC1dLBs72uR52vn+cj8kfd
   qDgWPtMMyvZVlDqZMjKcmkjTwLj+9JsbOSsEIw8eBs6poDXehmsJPNpFh
   MdL1NIGNxsph8OVFifZqgxI7nWhL9YIYQTsUkuJXjfADX4fyy7tXxzuQd
   NRXmmKYuUQ40FZd3FftD/90Lo16f/XQFSni15pk/FYqfMsq78IqRvEJMO
   JUbrB/SC3S0eKlqSFQyVoXeVgSIJSYowkcaoQC1QGyQsrHC+4Owi2UAg/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="301444306"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="301444306"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 13:12:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="743633115"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="743633115"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jan 2023 13:12:06 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 13:12:06 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 13:12:06 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 3 Jan 2023 13:12:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDD29kNK4RpY9LxDzZGxoO9p+cgegYobr32Sa01TyiiqJvn3kSCH0CNKIM/gw0xvlpL5rf/7qAchgUlvCB6ekVAqaRpNWlMRVtad0OZHRhgtBJlrf+RqkSSOLWmMeIhBU8Tg8BMLtth1n4XyFGz9PLUunwTHjRCnDi/Rl+P97f6478x99/T+LaQ4BK2yGbRztLYelToPaXg9bHhztBrjR8mKN/Q9abPuM8MNYA6h1fyupNkJnnYgQjeumXSDHQ1a70VQx+ZS+HfR6s26IHOa8/d/31Kkhj0OdNwqCRRmVZ74BfuC/kM5nIvQFkb5zfIBMLRf3JMUuESzTrBJuLYrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWwyLsG1BJVU98RtkNacC6nnJi0N+PKV3cJiXuAEBCw=;
 b=Gsob8+PvAVuNfa8PfATI6FjrHb6C3QdQNLGHixJmQZbaiDyMeHAxLPONFdAGiviXmLWpm3glF9i+4E8VBAdAcGRzNVpoLWTh+Ppc5N2rluQ1UIPwq7koUnfb6tVYD1x+mcAdtCCtOufRr97t7755P7Wu6A+mbSiJKkSypSSrO2Uj0C432Ta77ATaTdb6xVS6k3ubhjNGYDVlhLn24DFhAAANESG7S2mF7PnmmN9VMQueZgKqBiQG6kueJNHD8ZhRqY11g8/gXwlXDs037xt7yvEzuHJ8uj5THTVdMJr0o3cFdIJ2yQ6f9Iuep8iyiWAYDLnuVIyUfS9MaA1eut5RrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM8PR11MB5589.namprd11.prod.outlook.com (2603:10b6:8:26::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Tue, 3 Jan 2023 21:12:02 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%7]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 21:12:02 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: RE: [PATCH] mce: fix missing stack-dumping in mce_panic()
Thread-Topic: [PATCH] mce: fix missing stack-dumping in mce_panic()
Thread-Index: AQHZBiod8rBYaoP1F0+0JAoGaAcDUa5aqxswgADD7ACAKX1GgIAACwCAgAAE7YCAANthAIAHiZWQ
Date:   Tue, 3 Jan 2023 21:12:02 +0000
Message-ID: <SJ1PR11MB60831AB2202FF0C3CF99EF1DFCF49@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221202163728.392509-1-linmiaohe@huawei.com>
 <SJ1PR11MB60830CE8C3F79C9531C8567AFC179@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <5cf492bf-9807-a091-6ac2-a953fce276da@huawei.com> <Y61/+V47qH/8OVxp@zn.tnic>
 <1e97c11d-99b6-c06f-b67f-c56ba6653d27@huawei.com> <Y62NVThhnGtnj71u@zn.tnic>
 <276c9e6b-d647-6f7f-7bd1-c1f45ca23261@huawei.com>
In-Reply-To: <276c9e6b-d647-6f7f-7bd1-c1f45ca23261@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM8PR11MB5589:EE_
x-ms-office365-filtering-correlation-id: 044384dc-3649-4c09-296a-08daedcf28f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GPkTeu2o5ee7bYQYcXSk6yxIiAmIa/bIbgafKPTbflfJpJSVkeiWEJ3j9l0SjRWpyredgHihAMawcoGXmKs5kEbrxBEidonpxmjDheQbzhWajeA42vXLExUP49xw8Gc6GZbTx+7k6NpA4plLXY7u0hx5578EmCgVBsnhSv8BV/pfyRY7V0z6i51lBKCQMvQbqhOYCL489yM3y43Kk1Zi30Got15gJ8feRX9UT+LNMTbuhOn5hKI3YALVZ3eY4CZa5iSZTTXfr40SGmUEx3GpzCkXFU51ma1NvwITApcHkQRo28Fd20uCkekOjBSJrjjzibXp8kb+FTTQyAW4wtInilM/Re5e2WqNHwbBl+3IvyYbDEcNXD/ZKJJkWtvQRH9kmNg89geAMQXTi2XhUYuCbla6djxxFQr63D/YehNJOiAPG/hCq5LGBrZmx+cLBFacbizkCGMfySTqtc3HhnY4r1ETfIWEjszPC7RN0KhHf+57EycwW6m8eAFf6eI7zw3P6SyzMUwrprv2htRjJ3MjcLP+iUmz4Yvp6G0+4Zk4MKt89E9cPIa4UnGHAkXfG9cnMGqUgJbN3toy89qGwuLnXZOZo5NgNP+xVQrjE5QwmDKeYx/MDRvDyYUro8mOlk8qOTBkRL+49BsXRoMm6R1R7S7PAYWKtWzW7NEsWNyuLfHxl2Gsz3yriMa1BpQD6MB0yRgHfpl6gxuOqAeGEZNFsdwBNAsClgZ7nwwDBMIP8oI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(83380400001)(186003)(9686003)(26005)(33656002)(7696005)(6506007)(55016003)(86362001)(38070700005)(38100700002)(82960400001)(122000001)(41300700001)(8676002)(4326008)(5660300002)(2906002)(4744005)(8936002)(52536014)(316002)(71200400001)(66556008)(478600001)(76116006)(66946007)(66476007)(54906003)(110136005)(64756008)(66446008)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3VOMUhhSHNwWEg4ckJmUHRoRFRLTXBqcGtwWmgrZWZaa2FVZU1MWm1jcCs3?=
 =?utf-8?B?S3JUYnJRczdmSHVubEIyYW5UNnlPVUNOMTVqem83Y09wd2tFYXd2YlpMNGVQ?=
 =?utf-8?B?MlNNcHg3aklpUlQ1cDMrKzI4Ri9PN2FSM012SlhqNVhFWWZlamQ0S2Ivb09C?=
 =?utf-8?B?TFZjRWhEZGFEL1V4THpxaEFXNHB6U3V2VC9aUGVwSHc4Nk9aYytNS3pxbUhU?=
 =?utf-8?B?bVBVb0QxN0lON1VmUy9uY0l0LzZneGo1dnlOVzFpaGY1U2N2OHRxRUhOWVBJ?=
 =?utf-8?B?Skg0cUVkbmtla1UzZEQ5TkVRUFBmKzZIbCtPKzdhRFlSL3hRMzRTMDVaSG1Z?=
 =?utf-8?B?eGl4WFgrNU9HbkhnV2R2ZjAzUXVwZFFaU2JpNnQzdWRNbE1hOW85ajNuTHNH?=
 =?utf-8?B?aS9MR2F0cktua2taQTFVM0J0NVMrRjlFRWZmWk9hMld6VXBuRU9ibFRLSThI?=
 =?utf-8?B?RFdyaUdEZ2w4REhjbUdpVjdaVG03dE82Zkd4QWZ1aVNqeldaVGJicVVMNWFS?=
 =?utf-8?B?VW13aTcyTHVVbW9GeWhXOWRqbDVINGthY3ZwT1pVWFlkejZxeklkSzhQTFJ3?=
 =?utf-8?B?MTl5ZDB3UzNDR2FtWWd6VEpZOHRyZEY3WEpEdUYwNlJNNno2bXBmckxHR3JI?=
 =?utf-8?B?andESjlEZ25zeTZWaWFKaVd2Wit0Tlc2L2VIakFkQXZ6KzNzOUdMQlhZcUtj?=
 =?utf-8?B?NXhCb0RvQWoweVJQREpiSjU1dzdQWjNLREg3OGtzK25nbktPdTZyM01QcEpn?=
 =?utf-8?B?bjFKVDZwWDVxZW5QS2FkZVp3bXRTMUpnL282RFJ2K3JJWldqbXViT2JRTjFl?=
 =?utf-8?B?d2xwVGxDMk1BWVVVY2FLM0FGQmJpcGlSRFcxNzVWcUFmYThzY2FWQ01ITjR5?=
 =?utf-8?B?Ri9MS2Z5N3lVSHUwWEl5MmRkeWRsSzJDV0dpbXRQQ29kZG5Rb1h6MkhQVVhh?=
 =?utf-8?B?a1VmSnJsMy9nK1dFM0g4MDdvbFRqMzgyUGp2ZEJzQ3ZvSGV4cjhvWStGSFJO?=
 =?utf-8?B?TXBhNEVIaXk4ZkF2Qkx0ZWVLWmNUc2UyRjFmKzRVcnM2MjJMQlRLNFAzUEdO?=
 =?utf-8?B?dEFKeXl2ZG1qZmZBNk1BUmFRNWg2dDBscUdZdDZMb3FHWkQ4OHhpdGJjY1Fo?=
 =?utf-8?B?ejl3UEFubHRySE82dnM4T296ZllHZDJZL1pLTXpwVHVmak9CMUNpMjNBa3VB?=
 =?utf-8?B?T2ozdmZCcHlmRWk5RWhFaUVmRkU1UlZUU284TklJUE1YZEhoUmRVa2lhUDUy?=
 =?utf-8?B?WnBEZ2ZoN1lLMVJhVjVrMTgwVlpJcjFyNVovaTJhd1BVUFluN2VtaE5PaTdG?=
 =?utf-8?B?SHpKTW1STEFMZHdaRldnM0xuK01SUXhvNnh3bHAyK21QRmJBaytkQkxZU2pB?=
 =?utf-8?B?aERyYmptWFNDYmRzZGxwNk5ZODQ5bERiRmROcUlwaGhKWnBrSEpKdlAxUmx3?=
 =?utf-8?B?eGwzbjRVaU0wSWJCUkJvNmNCZXR0UFpNZzk0MXl2VXJ3UC9ZR3lBL2lYYTR3?=
 =?utf-8?B?a0N2N01LSEZHN0h1QzZZb0lmczhFRXoyUlIzZE1LWHFvYThDc3Bsd0U3RmtT?=
 =?utf-8?B?NFBVSEdvcWhOYTJDUWNTQ29pMElndFZJS095ek9CcFdyNXN5UnV4dVZ6VHBY?=
 =?utf-8?B?YmZjb2JwM1J2SWFlT2NWc2RmakdXQzFxNEtySnZsSk5tUHU4THpvSmxyTmpV?=
 =?utf-8?B?bVowYTl2SlJrZ2xnQ1F2ekNvRlJTbzBzdEdua2o0RHZId21ZYXNIMmhYbFVz?=
 =?utf-8?B?dXN4ZndLQ2gzT2tOV0FBVzRoQjBwNnFFTHEvOVBQTldROXdXVmZwU2ppV3ZI?=
 =?utf-8?B?WFZoNE11eS8rUGJNcXFDOHUxT3FYaVhOUEUwclVtVUt2T3dZNlhaR2Q1Q2E3?=
 =?utf-8?B?NG9DcE9MVXdtSjJFQS9GS0NGY0NTaDFtS2RHWFB2N1o1ODd0OXdmelJEMmpv?=
 =?utf-8?B?WFpQTkl0ZGN1YjJ0Um0xRU1ReDBNWnVHZ3paWEttMldkdURFM2dRS0JGeENi?=
 =?utf-8?B?SzhLR1ArSUtldTdTdlZuOTQ4c29BRWZLVmp2eVVmWW1WZDBORFRDSXZKbDdN?=
 =?utf-8?B?RkUyWnU4bnNZSmZjaVdraldjbHk4MU0zUWI0aWNSZTRVRTZkd2dsdGVxeVh1?=
 =?utf-8?Q?eJkixts2PexIWFN7X1uUI4u59?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044384dc-3649-4c09-296a-08daedcf28f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 21:12:02.7137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NbA0spXssRWpO7813Y7g3Mq8b4k+zSlFZgfeCOk9OMaZrOouzxh8cOscqRNKX11W/1j2SeFeEfZneZHzEyt+/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5589
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Pj4gSSBndWVzcyB0aGUgb3JpZ2luYWwgaXNzdWUgdGhhdCBjb21taXQgd2FzIGZpeGluZyBpcyB0
byBzYXZlIHRoYXQNCj4+IHJlZHVuZGFudCBvb3BzIG1lc3NhZ2UgYnV0IFRvbnkgc2VlbXMgdG8g
d2FudCB0byBzZWUgaXQgbm93IGFuZCBJJ20gbm90DQo+PiBzdXJlIGhvdyBtdWNoIHdlIGNhcmUg
YWJvdXQgODB4NTAgc2NyZWVucyBub3dhZGF5cy4uLiA6LSkNCg0KSSB3YW50IGEgc3RhY2sgZHVt
cCBmb3IgdGhlIHNwZWNpZmljIGNhc2Ugb2YgYSByZWNvdmVyYWJsZSBtYWNoaW5lIGNoZWNrIGNh
dXNlZCBieQ0KcG9pc29uIGNvbnN1bXB0aW9uIGluIGtlcm5lbCBjb2RlIHRoYXQgZG9lc24ndCBo
YXZlIGFuIGV4dGFibGVbXSBlbnRyeSBmb3IgYSByZWNvdmVyeQ0KcGF0aC4gVGhhdCdzIGEgcG90
ZW50aWFsIGNhbmRpZGF0ZSBmb3IgZnV0dXJlIGtlcm5lbCBjaGFuZ2UgdG8gbWFrZSB0aGF0IHJl
Y292ZXJhYmxlDQooaWYgdGhlIGNvZGUgcGF0aCBzZWVtcyBjb21tb24gZW5vdWdoIHRvIHdhcnJh
bnQgdGhlIGNodXJuKSwgYW5kIHRoZXJlIGlzIHNvbWUNCnBsYXVzaWJsZSB3YXkgZm9yIHMvdyB0
byAicmVjb3ZlciIpLg0KDQpGb3IgbW9zdCBvdGhlciBtYWNoaW5lIGNoZWNrcyB0aGUgZHVtcCBp
cyB2ZXJ5IGxpa2VseSB1c2VsZXNzLiBFLmcuIHNvbWUgQ1BVIGNvcmUgc3RhbGxlZA0Kc28gdGhh
dCB0aGUgc3lzdGVtIGdlbmVyYXRlcyBhIGJyb2FkY2FzdCBtYWNoaW5lIGNoZWNrIGJlY2F1c2Ug
aW5zdHJ1Y3Rpb25zIGFyZSBub3QNCmJlaW5nIHJldGlyZWQgb24gdGhhdCBDUFUgY29yZS4gSW4g
dGhpcyBjYXNlIHRoZSBtYWNoaW5lIGNoZWNrICJtb25hcmNoIiBpcyBhbG1vc3QgY2VydGFpbmx5
DQpzb21lIGlubm9jZW50IGJ5c3RhbmRlciB0aGF0IHdhcyBleGVjdXRpbmcgbm9ybWFsbHkuIFN0
YWNrIGR1bXAgZnJvbSB0aGF0IENQVSBpcyBnb2luZw0KdG8gdGVsbCB5b3Ugbm90aGluZyBhYm91
dCB0aGUgbWFjaGluZSBjaGVjay4NCg0KLVRvbnkNCg0KDQo=
