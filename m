Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ACE59EB1F
	for <lists+linux-edac@lfdr.de>; Tue, 23 Aug 2022 20:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiHWSfv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Aug 2022 14:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiHWSfV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Aug 2022 14:35:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7589D110576;
        Tue, 23 Aug 2022 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661273889; x=1692809889;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eP2Tgo1p8tmjl0IkbucjUyvhaHMiA7n2pkUydMIvJ5M=;
  b=daUL4oBFgAnFIkVTPIiNzAqDj47C7f2m28l0TPjTWoLp8YXO3RI+BZyv
   R/wTkbLr5a6yB8pqVnDkmf0qv1MP3Js46CT4+k8qmaj+wjGSVSOaLoGj0
   779fi0Kh6rNlHLlwRQfAApDsYk/X1eI90ZERBCYcOj4uLQo0/isWkWcTJ
   1WOep+jAC6q4jw04ZYbBIBFLmNGAMdMYDN1x21W62d3Ku8socBIxm2vVS
   Njr0uH4z9dEW4rNopfTXSUnE4lJivPHJEQsIjJh/V7QnZAaKvoUlsmVKQ
   gfG4u0rqcbHRwFV1ZNP6pHyyiF0Ahqmnl34jeZBAUnWtxpSU8gvhDvE2h
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="355472431"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="355472431"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 09:58:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="642512062"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 23 Aug 2022 09:58:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 09:58:07 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 09:58:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 23 Aug 2022 09:58:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 23 Aug 2022 09:58:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhHgpyUpbrLvKZj6WI/blqkt6L8sJrpJaES3ZJ5CLDc7lDR8/e2AFot0nRnvTh1vfLezvMRa1Okyo3TTd/XC7hM5gZmOeH+47/c4i4ugJkTIgWpTFUioQy0mPrkhwiA4f26oVMmO4GWYddVKstIV4gqigtWaS3z4uW8atTbBfoKVBYX+G3J62gMrvXBLpcQ9rv8Dowe7JozNu4IGMzTUpt0wqoX2mmHIBYV1pzSlt0SzqaCyyOLFPImJu944VBOgIqC4lEeaj4DkKIrz3W6iJx47X37jCM+xz5fpwenoeWomqNOy76bTkWFExGweitr5z7cHnDmyXxnEQnF9F+ss+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eP2Tgo1p8tmjl0IkbucjUyvhaHMiA7n2pkUydMIvJ5M=;
 b=TOQ0Trrz0tDY8IHPy7u9VEK0XvIm0Lgrg9WKBiB5tasBm6UNxwKvPY5jYjYb/cE+mRe4fybKcYU/5g5wnmx0fxqXrB1Adv2Wf9Tp7dwyfccZF1X8vTQ22GFc2gxV/K1pB4WECCikCz5KM4++rrblvOxBqLgiv84HsvPE0d/Ew+lsKoL/BRPIkC88cqdoPNdDUvBYxqm3Bpk00WZp/QYECO1NLOSdDTRbhwdwXbmvkSUayUeuRh/IzX+LqOjuy8/4t9hky6qjjED7iPJGNP5khFhu0wRv2FHX0Ln5G565D04WE22lRgUIJS28DIXh5eDJIRR7MzBadO35FnsoH0/Lcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11; Tue, 23 Aug 2022 16:58:05 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::8daf:550d:185b:6d5b]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::8daf:550d:185b:6d5b%6]) with mapi id 15.20.5504.024; Tue, 23 Aug 2022
 16:58:05 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>, "chu, jane" <jane.chu@oracle.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: RE: [PATCH v7] x86/mce: retrieve poison range from hardware
Thread-Topic: [PATCH v7] x86/mce: retrieve poison range from hardware
Thread-Index: AQHYpqlEyW/lSjmac0Crzl9ODqJstK280+EAgAAAviA=
Date:   Tue, 23 Aug 2022 16:58:05 +0000
Message-ID: <SJ1PR11MB6083C23BE7762FAC64717FABFC709@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20220802195053.3882368-1-jane.chu@oracle.com>
 <YwUFlo3+my6bJHWj@zn.tnic>
In-Reply-To: <YwUFlo3+my6bJHWj@zn.tnic>
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
x-ms-office365-filtering-correlation-id: 309d9764-5863-4b73-0eac-08da8528a5a6
x-ms-traffictypediagnostic: DM4PR11MB6043:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YrEt38u7DEh2jkdWKL/qcmFZGu/xA4SGQ8O7C8rLz9qgsAtc9Ppom4Os13A7aT7b5oswEs/c5JX6ok/UREWZKn+RXqa7dY7OuG/qzbdXeTE9+TX9Aa8CEIk/JvJkV8yKyF570xBAF3aE66qhHrKOSkRuP6sjm2iIdJbK/tXeXwFrMypmvdT61v7lxmvS9uENYAwxpDq/NI7z9sLPF3z7VDYuJlZzaejDwfx1dhSQRl14beMaTyq4KyG8p2KwvCjkx+vf0GMxgYVvzmzMmTYJbmbYgirN2/kVepP3+IcknW/vIWgyqYXhmGHkdDTwFni8Sekow3PuwyRHvlV25RXViSHY7faWyQBacHVm8f8MJEcOBgOxBdaVzII+f/x2IKp98G8Xc5+gOq24jXVzs0mINLyUekyS21OzBgMykc+UU3dZOYXz3xITqab1pqx4UUL+v3dPgfZ7ANtMveFnbgSnwV+s1/++a4i2W680eYdCgW2acgbY28AFUv7fP6gCpBH9mXPJCQ9K143rtjsH+V/Y2lDnUbQBmdbSvYuld2Zcf8vTnh676LkHtKBkalfimyWxuxhtndJhRwX/qLEo3Q8ebk/v/uqCSsxvvZn7/332LAm/G61Alq+zaI5/YDwfurew1jOKgb3bfmQcGKazcQQpQd3OVBN9RYOl7VYU71geWzkCE7Ghgu5+Y3EHvd5AAkr3Gh92+6zuBlZPqPOrcO8kEAWQNtKZsXOUIAu+HLJ5ccu4IVpvB00Qv0Zxz/cZ+AJ+9N3dPnDxmkvZYK6bIo85cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(346002)(136003)(396003)(122000001)(186003)(86362001)(38070700005)(26005)(7696005)(6506007)(33656002)(82960400001)(478600001)(54906003)(55016003)(4744005)(9686003)(316002)(66946007)(52536014)(41300700001)(8936002)(66476007)(2906002)(66556008)(7416002)(76116006)(66446008)(8676002)(64756008)(5660300002)(71200400001)(110136005)(4326008)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk5Pdm8rdCtJVnhwQVhnRWRacW1aQUVUSnJYU2hNS1RKcUdiL21DVy9kR0dE?=
 =?utf-8?B?TjJPQjFHTVpKR29HbG4zVTRmb2ttRHNZYXNISFJocHpzWlJTT0FsNWQ3cWUz?=
 =?utf-8?B?OUlBNVhqUUlPbmplYXlpTTI2a1ZkYllXS1VlT0NFbDBvcitvUWRNRU5pR0k3?=
 =?utf-8?B?T2JCL2hJdnZPNG5RL2srbEsxTW9OM0NqS2tyRVVWNHZhVWgxVGFnNUVpTlho?=
 =?utf-8?B?OGo3YU5xQmxnL3N1M0tYMWJBNmk1VlU0MmMwMWNFRnFva2J0TVhvc25CUnhv?=
 =?utf-8?B?WlNzbnBNNHVZK25Td3lQdnloOUJNVm5aRWlUa013UWxvK1VXTEdsMEM2TmpE?=
 =?utf-8?B?cUxvcmJqWVZIaStKOUpaOFpYckdKTkNPTnZlbUo0cDB0SXhvOURoWVhOcnVR?=
 =?utf-8?B?R0dkMVR5MmFIb1U3bVVvT1RqSkh4YktjZWtHcGJLQmVOTStWTXlibEhrNzBW?=
 =?utf-8?B?Y0lCbm5xbWVNaXZpWFNHR1djU29YNUVNa0IxU2hCeFRXMHQxRW9sVi9WZFNF?=
 =?utf-8?B?VVNjVmNqNkpub1pJNVVhVDFDaUVLcHNHb0lkN09uMVVRdW16aUtlVnJPeEMv?=
 =?utf-8?B?RTFSQy9qQmN1VFF6SWJGVmJIN0M0NzhBbG83U0FVK01Lcm84ZCs0bDRRZm9J?=
 =?utf-8?B?bzMrL0J1K2xxWEx1RFhSNEhWVFhBYnVmYWpUVjRMQWM0SWIvVm5Jb3BFYWVI?=
 =?utf-8?B?YzVwRW9obUVoUFptZ21Fa3Y5cjZmZFhEZzIyNG1VMytpYWlhOFZyVzY1NEZz?=
 =?utf-8?B?MTBtdnJSS2JxYWFBL3kyMDhKVHdnQ1ZsMndtK2t3NXpvL0czZzF0bW5OeHNu?=
 =?utf-8?B?RXlqeFBXL0N0VHc0Mko2RXpObnB1S1FjRWR5bDFZR1QzdHF5Y3RpU1JBK2Vt?=
 =?utf-8?B?bE9NSjdFM1dBcXprWjF6UHNqK3VKUXZ6cmhiOHNqaHRORlJGcVJjSlJmQjVi?=
 =?utf-8?B?YmlZclZHc0pkdENpcUt0eGJPaVR4dU1Jd3JCbGdDdEg4ejJMMXpXbGtVVk9u?=
 =?utf-8?B?T3h2OHc1bzB2Rk96RGhsdlpVY1FvNU9ZRVgyVStUUUdsVFZEZW00RHM3bVpv?=
 =?utf-8?B?T1Fkc1ZKNHdrSlFIZlhmT3BvU1JTUktUcmdsWnIzWWJsRmd6OFc1ODJmdXR5?=
 =?utf-8?B?SlZWb0JlN1ROQXBibzVDMjlneTIrdlZjQ1cvMnVoTlFhMnB4UE9KaXRaM0RI?=
 =?utf-8?B?MG1HOEVnV2ZrOTBneEJEanBGdzhjdjI2bW42V3lsVDczMGQ4Zis4RjVSU2xG?=
 =?utf-8?B?VmRlWFAwd1l3TzJtVmVCcGlGWE0vUkwvRHBMbDl0ZGQ2SXNEZzY3aE9EY2RV?=
 =?utf-8?B?ZDRvRXVLR091MERySjdUVGZXQmxsSmgyZXZpVjRycmY1T1hpcUlLRGRrV0ZT?=
 =?utf-8?B?dm9tSnhFcmhBaVAwSy9YOUFJekdiM29GcC9ZTUJ5Wlg2Q2RmdTdYZXBOOUdK?=
 =?utf-8?B?TnRmZUlqcDNIRDlHbUhGK0ZIOU8rUVpRZ095K0F5SU5ZSHhDMnowMWpnSVFT?=
 =?utf-8?B?YVg4R1ljRm8rVXlndGRSM0NXTCtVZ1dmMDRNT3JXYUFkRDZUd0krK1Q5d0Zr?=
 =?utf-8?B?dzdmOHdMUGc4Yy9MSnZjZHBOOUVUSlp3R0I1VGtyTjRLMXdpZDg0MEJPQ2hq?=
 =?utf-8?B?OTNkVVdDRUQ4cVdPemhEa2ZlUzlNdVRrMnoxODl4RzV3RS9ob2pHNHB1ZEVj?=
 =?utf-8?B?V2k3NWw2TTA5NXdFaENHcHZWcWJ1YkRBNkRTaUk3L080VzRyQWM3QVdrT0JG?=
 =?utf-8?B?L1pOVmoyZE5LaXJwUjhjUDRxVVIrMlJLR3BqM2k2WmtEdzFsaDlaZ0JqWGVD?=
 =?utf-8?B?M2VhbGRWVGxiN01kWi9DZkc5dHpFc204bGFFVWJ3T0JURU1pcVRCZ1FySTV2?=
 =?utf-8?B?dkV2QTR0VzhCL1hqR2RnRldwMHdLSEczMXFyQ29UVmp5WHJCd09RTjJ6ZG5V?=
 =?utf-8?B?T253a3ZkS0QwMzVoRVNrVjlXdUpnK3IvNlF4WEVyS0pnOUFRcktKZnhRL0ZF?=
 =?utf-8?B?ZUJMako0VFR3emdOaGJRSnAvVHNoRFB1M2QwZXlXMzBUVXVDUXRkcUFKQ0pT?=
 =?utf-8?B?RjBnUlI0QXd6d0Voem4yNE1DSTRVMmFZenZWTThvTUFpOEFlVytPeVhMQXEx?=
 =?utf-8?Q?RfREFJ/JqRrlLDAax6+efqpR0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309d9764-5863-4b73-0eac-08da8528a5a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 16:58:05.0499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tuGRIypeVG+O3j6B8ePAQ3hcP4uvix945B/m8Gq8Kzocdm/tJ87A4LXgIzPkJ2zcHIuzAzox9AJSpepE9+LCAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6043
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBXaGF0IEknbSBtaXNzaW5nIGZyb20gdGhpcyB0ZXh0IGhlcmUgaXMsIHdoYXQgKmlzKiB0aGUg
bWNlLT5taXNjIExTQg0KPiBmaWVsZCBpbiBodW1hbiBzcGVhaz8gV2hhdCBkb2VzIHRoYXQgZmll
bGQgZGVub3RlPw0KDQpUaGUgU0RNIHNheXM6DQoNCiBSZWNvdmVyYWJsZSBBZGRyZXNzIExTQiAo
Yml0cyA1OjApOiBUaGUgbG93ZXN0IHZhbGlkIHJlY292ZXJhYmxlIGFkZHJlc3MgYml0LiBJbmRp
Y2F0ZXMgdGhlIHBvc2l0aW9uIG9mIHRoZSBsZWFzdA0KIHNpZ25pZmljYW50IGJpdCAoTFNCKSBv
ZiB0aGUgcmVjb3ZlcmFibGUgZXJyb3IgYWRkcmVzcy4gRm9yIGV4YW1wbGUsIGlmIHRoZSBwcm9j
ZXNzb3IgbG9ncyBiaXRzIFs0Mzo5XSBvZiB0aGUNCiBhZGRyZXNzLCB0aGUgTFNCIHN1Yi1maWVs
ZCBpbiBJQTMyX01DaV9NSVNDIGlzIDAxMDAxYiAoOSBkZWNpbWFsKS4gRm9yIHRoaXMgZXhhbXBs
ZSwgYml0cyBbODowXSBvZiB0aGUNCiByZWNvdmVyYWJsZSBlcnJvciBhZGRyZXNzIGluIElBMzJf
TUNpX0FERFIgc2hvdWxkIGJlIGlnbm9yZWQuDQoNClNvIGluIGh1bWFuIHNwZWFrICJob3cgbXVj
aCBkYXRhIGRpZCB5b3UgbG9zZSIuICI2IiBpcyBhIGNvbW1vbiB2YWx1ZSBzYXlpbmcgYSBjYWNo
ZSBsaW5lICgyPDw2ID09IDY0KQ0Kd2FzIGxvc3QuIFNvbWV0aW1lcyB5b3Ugc2VlICIxMicgKDI8
PDEyID09IDQwOTYpIGZvciBhIHdob2xlIHBhZ2UgbG9zdC4NCg0KLVRvbnkNCg==
