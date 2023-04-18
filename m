Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FFE6E6CFA
	for <lists+linux-edac@lfdr.de>; Tue, 18 Apr 2023 21:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjDRTfS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Apr 2023 15:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjDRTe5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 18 Apr 2023 15:34:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2C44C21;
        Tue, 18 Apr 2023 12:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681846496; x=1713382496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tUQDYdpbrYEKvfOEEpfo4kkuuI0pd3ig7jgmmI6qtuc=;
  b=bzEt1j5J0Wf18To4io0wk35Ms6PJE6YuW3If0q/Mm2/6fZIpcplr59Ee
   zRjSQSOL26imdU/AydWgfZLRydfackaV3YoR88YuvWkahEBADTcNrRgwp
   iAWrETBMKO/dib3c+IkFfQit55GvMCq+8bD0h+WvMS+I/OPr9bbFVdmue
   MPHfRaGH59QsSLnWZ/9z8DxkkurXZ3h0sJfOieeTQJ0kvKs3TcD0IMTSc
   D1sUamBMdPf/qaiWV205KSmtjePSFcan+dz++naCsxfw3wxEUi/QAUk9I
   fLGKI8J/lqvGQuVixsHvwGBNO5uOa5A73UAoOOwOHkcYWWKm3mSvjcYy6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="431551561"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="431551561"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 12:34:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="641483236"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="641483236"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 18 Apr 2023 12:34:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 12:34:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 12:34:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 18 Apr 2023 12:34:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 18 Apr 2023 12:34:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGgAUlfplk6Lwb2aosyxdW8xW3A842m/yf5ZyhFEOYh/y7L+PGGWemxKBW358rEOOCTOrIrQD0Hq+WeXayG/28qlIZJiRKTSvwj5lzRTrNy+7+h23BBS13zBt44wOB0+lA0qwvBNApXh+IkVr4aFrkUJUNCc8DvJsYomvY0KSFl6ztCoJafv0nW2H/djqgIUc8agBzkoQsT+dqMqOJNpIPdjaW3+ukbR7TDnTvubGr01H0ViW4jki+L3tcBMDF+XeEmhMf4a1jYnsGBfytiQKqX9poHi5tbzQa5i2m5mvhSoumyTC2yL4v6jq7zMyL0f1qHpjF5yBpb9SPh/EOMDsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUQDYdpbrYEKvfOEEpfo4kkuuI0pd3ig7jgmmI6qtuc=;
 b=WHWs85ssCn3S+1GMUvtAv17NP2ETX69qi9UMvbA60WCaVIOxu4QBW8e/d0F3MhhmxC1WB1FkfD3H3OMcOYdd/QMHNH0exVPFGZXHC+rK0zu53zW98AAeCc9hLGa/Xmt/xMe+/89lNyDiE9v064BGLQWrQ/RhB07CU9cgFGNgYmRoAC/xX6XhBqyWPRvk9HP+Zq7k31dr1r7RQ1Zyw9WRLUUCSsLxjOAzANf+rFNbe2wU/fRjKZRaQR7jgpB1lU+LQb1hg5H4FMIu6318MUgaRi4RDN15Cm8X50KoqKVHD1qbto5t5ey4UK0r+pFryURmxlqQwiUm+G69uFjcMJurug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB5994.namprd11.prod.outlook.com (2603:10b6:8:5d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 19:34:46 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6298.030; Tue, 18 Apr 2023
 19:34:46 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v2] x86/mce: Always call memory_failure() when there is a
 valid address
Thread-Topic: [PATCH v2] x86/mce: Always call memory_failure() when there is a
 valid address
Thread-Index: AQHZciAsXrKb1rM5fkSNe8Wyos+1L68xX8yAgAAUcJA=
Date:   Tue, 18 Apr 2023 19:34:46 +0000
Message-ID: <SJ1PR11MB6083BF7037C9C86E097FCAA0FC9D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <a5d0c575-ba4f-1120-c7ee-bc37e8d40402@amd.com>
 <20230418180343.19167-1-tony.luck@intel.com>
 <93d0e5e9-eec1-cdab-be5b-cd65f792e5ac@amd.com>
In-Reply-To: <93d0e5e9-eec1-cdab-be5b-cd65f792e5ac@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB5994:EE_
x-ms-office365-filtering-correlation-id: acda36c5-76ed-4e28-589b-08db4043f774
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EN0pTx7WPasw9O1GVTlSvbRdxRVFPYXI6r5WDLfDjrUwx+hvlHbhk6HvQXOCSlwCX6XbCYEhTvyDokYF1pgokRzW6njkihbV4vPtK8/exHICvTuoaTA0DktZqYpGDlilOoO7UivZZBpfmb8oVBFM6pBlX7Bw376R2yh5egRE66dYqMQ/xcft5ms4EkNbYVgwj/YsVosCMDbQdfqQdxh1N95Il4dKrdHwZ1UhaO1YJVu6xWkY6BK09lmqBJXQrf+g9XGaRWQHWP2oxZjdtsz8lyqGwvcAhFNWvYffFnUtUgXT22nqRLL9YM0WCE7x9oXSPfI1oIoLhuHGEaaiGK5ijutHmALIggRCAAjbQ/2pSbdrued3M0oaD1SAN5q38Z2StXlpwW4b/u/t6EsHd7y39Kav1DSzodWWh3slwe91u50qMUeFlZFvxaeVoG/Yl+uCm2CRp5bB4G4xmLdH51DbmJxo84MhZpHgUBBV6A3yuAOZi+8qoT+jpKOb0AgB+yJA2RKpLuEtYj+rqyl1qLyA/UP7ksOq7Q/nA96x0Zs3okGFHQrZw3YA8Rr0UzRhPXmTyaYIyvqDvdsVPKBdYibvFrKBOwm59gAiFypbSUtLUn7Ii2Rv3AIt7bhsvg2X3fsA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(5660300002)(33656002)(38100700002)(52536014)(8676002)(41300700001)(8936002)(110136005)(55016003)(316002)(186003)(6506007)(26005)(4326008)(66556008)(76116006)(66476007)(64756008)(66446008)(86362001)(66946007)(9686003)(122000001)(82960400001)(83380400001)(71200400001)(38070700005)(7696005)(478600001)(54906003)(2906002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTJqa1hVTmd5VGs2NGFleFl4Y1c1K1QvTmU0ZXVmRldzdWY5L3ZtNW9QYktP?=
 =?utf-8?B?Rm94RXRDOC9VdEpyUGVkUjF6ZVlQU2F5MXNVbmZWV3dsb1hiK1dmcVNxWkNs?=
 =?utf-8?B?QTFTdHpPMkZQek8wR0tkbXRpbUVuMGZiZ2FHbUt2d2ZwVjR0T2FLY3FGbmxY?=
 =?utf-8?B?UkVEeENvZzV2OHNPY0QweFFyc3gxQitoMm03enVHWmthd2VzV3RpaWRMZVdM?=
 =?utf-8?B?OVhWek1nZ2JGYnRaa25rc2RzVUxLK3ZxQWJxRE4rSXJJclUxTWoxRkljMHly?=
 =?utf-8?B?Nm5sUXhXMkRtcmswN0hocU5XZDBaWU1zQWhMeVQxLzNQZlY4RVllc3RoVU1H?=
 =?utf-8?B?bFVtMmhpYllHZ0V4S2hBbDBBSG44UXhOV2ZkNlBWNktCYTRQQkdnai8vS2wx?=
 =?utf-8?B?V3RKWFJYVDJZcHR4TUNHR1A0NWhqdWxzTVhTSnZkWDB0V3U0aWlvM2lSNjg2?=
 =?utf-8?B?cC9PS2k0ODQ4SlFlRWNiSmU3SC9WR21vNWFPNnduT0NMcVBqMHpQQTBGS1ZL?=
 =?utf-8?B?NDNNcWR3emplUDRha1NkY3Fwd3NXOXVpSVovL3lHdktaQWdTUnRwR2JlbFdQ?=
 =?utf-8?B?YVd0c1d1NGlSc0luRGdud3ovaXkzZG1TaVBWTzRGS2VKcUpsbnBSaFdMY3Bs?=
 =?utf-8?B?bC95T2FPdHp6M0tWOUxncGlMd0hqSkpJazBKVWhjeXVrVGJGWUtnOFJaV0Uz?=
 =?utf-8?B?VzFtYURkVHo1M3pmNHIxc1A3ODBhbW9RRkJvekNvRTRUL0lkVE1OYU9sZTQw?=
 =?utf-8?B?NTZxdEdEZWpYVkp3aUp5SWNDT3JWMlg5VmdDZllPZllhYVBjenVUREhETFY5?=
 =?utf-8?B?Y09IWFVrSFUvS3RDVkZMMGhUWHhGaUZMVHU5NnFUUk1qK24yaTlleUdpTHZx?=
 =?utf-8?B?amF3YUQvTnl5c3IvemtGQ1RBa3lwZDI2Zm1va2FMQTNEclphK3BsSmhZMXRm?=
 =?utf-8?B?clRUT2dWWXFuQm5iWGxrUkkzblloRkRYY2IvWlFmS2JTZUpHaFhoWFF3clhY?=
 =?utf-8?B?OElvK2FmUVNHaE9JUzE4T1IyMEpFQ0ZoSDhtcFlJeDlHZTRBNFFxT09zdnlH?=
 =?utf-8?B?TW9WYlhCOWZvd2wxaVM0VWFIdHlwakc1QkNiZXk1WmZwUWVycEdzdS9lNytn?=
 =?utf-8?B?RmtMcFpJMmxlcStxaGFZUWNGUXU4RjhYeFlkckZDenhvemYzU2J0M2xoaGRa?=
 =?utf-8?B?VHFlTFkxdGV6YkdiOFlrTSs4ZlVMaVNMZUhGSDg4OUhlb2VWMVg0V0QzbDNL?=
 =?utf-8?B?cU0rWk91eHFHL0Q4VUt5L0luUGpxWXdPR3BVd0wxTFU0VlFHZjR5emdaaSts?=
 =?utf-8?B?aHNYWEl4TklyV3BsWUZkR05oQ2N2eFE4aHZwWHRubkpBMnRPUmhIejBDbElm?=
 =?utf-8?B?RDhmUm9qVFJhYjY3bWtUbWdaNXl5RG1mNS9hdFYxZHRVS25TVVR5SUdIdnFH?=
 =?utf-8?B?eVZVWmpjd2tnUkZYRlRVbEt5bFhWSTRaWm5aWjZ5SktYaURGbUcyMC9ZL3VV?=
 =?utf-8?B?R1lXUFhWbjZidG1DVTB1SzBRb1QrMjE1bmw2c2xyOHRzWGZ1VVFCQUlSSGU3?=
 =?utf-8?B?dXdiYkdDSFdPdkNWV0ZXQkNrUmliYjIxb3BPTTl2T3ZGc0syTnNFdEo5bUxv?=
 =?utf-8?B?Z21DR3JhYk03bDlDVmNweTc4M29XNXlrMXBjZlorbStkWU9rK0pRekFUcktQ?=
 =?utf-8?B?NzdQVzNLNWZ4TG9JUnBEMEIzYW9yNkxNUnFKZG1yZjBwYitIM3l3VnFlZHl2?=
 =?utf-8?B?TXJaQnBHbFhIZGFMNkZOV3ZDYzFNc1ArRHc0eXVvTkRmREVJNG93RFVNVkU3?=
 =?utf-8?B?ekhYNDN0UEpYc1NzeGVTZS82UHhUWnZjaGlTcWlzZC9HT1FkSUF1MEptMnF6?=
 =?utf-8?B?bUYyd0ZXRW90NnZwV0hJMTc1MEN1dEJRZ0ltMFBWWG5BNFM4K2Z0ZHBQOUly?=
 =?utf-8?B?NTFWRnhRRTRtam9SbUliZEZJeExzWk0yZnZ4VHJpeXFxdkJnOGF0R0dnc1hE?=
 =?utf-8?B?bWNsOENZMmhpWlI2anUxNGM2eStqZi90NWQvenlTd0Y3R0JweW9lSHR2b0xB?=
 =?utf-8?B?dmY1VE9KVituS212QlVhK0doVXJEb2Jmb3dMUWR6UStBOUpYQStWUzdyUzJL?=
 =?utf-8?Q?BpvQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acda36c5-76ed-4e28-589b-08db4043f774
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 19:34:46.1117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bZ41XkvLldhdoAS/9MffEiloL/gStYYgTuaXm3NNfKld4SHTCb/fPSrNM+eoxflYwvZUxpPt+MjcoOcKYdmVsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5994
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

Pj4gKwkJaWYgKG1jZV91c2FibGVfYWRkcmVzcygmbSkpDQo+DQo+IFRoaXMgc2hvdWxkIGJlICFt
Y2VfdXNhYmxlX2FkZHJlc3MoKS4NCg0KPiBDb3B5aW5nIG9sZCBwYXRjaCBoZXJlLiBGZWVsIGZy
ZWUgdG8gcmV1c2UgYW55IG9mIHRoZSBjb21taXQgbWVzc2FnZSBpZg0KPiBpdCBoZWxwcy4NCg0K
TWlnaHQgYXMgd2VsbCBqdXN0IHRha2UgeW91ciB2ZXJzaW9uLiBUaGUgY29tbWl0IG1lc3NhZ2Ug
c2VlbXMgZmluZS4NCg0KUmV2aWV3ZWQtYnk6IFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVsLmNv
bT4NCg0KDQo+IEZyb206IFlhemVuIEdoYW5uYW0gPHlhemVuLmdoYW5uYW1AYW1kLmNvbT4NCj4g
RGF0ZTogRnJpLCA4IEphbiAyMDIxIDA0OjAwOjM1ICswMDAwDQoNCjIwMjEgLSB3b3chDQoNCj4g
U3ViamVjdDogW1BBVENIXSB4ODYvTUNFOiBDYWxsIGtpbGxfbWVfbWF5YmUoKSBmb3IgZXJyb3Jz
IHdpdGggdXNhYmxlIGFkZHJlc3MNCg0KLVRvbnkNCg==
