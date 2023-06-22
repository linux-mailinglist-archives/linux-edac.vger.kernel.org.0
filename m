Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB27173A917
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jun 2023 21:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjFVTnC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Jun 2023 15:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjFVTnB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Jun 2023 15:43:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F101BF6;
        Thu, 22 Jun 2023 12:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687462980; x=1718998980;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PRFFd4A6xGHNTFA4Jad5dPLntl21y6xqY4iYsbuFhW4=;
  b=VtwmRatm8tAhjLQifVlfVHS1c+Q2xk4dtmGKR3P3odZUt1uoVDXzex7H
   EI/7r02RTCae3kYH24KiRkBqor0S/68mm3v/9tEHwSJ3INIW+pUIUHTj6
   KjmChmkiPiCdFpnMiZmnVPBnbFKW+Yhk2y/LiHE3svkRFBIS6Caxf3drX
   x4jd7vqCNK2IB2wl79CHQBRAVNvgMyt5mkx1YpqSD3oRV3aFPUha8CYaq
   KQPoQIqp2YlZ1Qfwe480cr48B5iqP5+GjAac2UzkpvX6jlLgPIRXhuyCk
   NAQdyeTwTcdXOdZAokY6nzBaBxbe/GKtSVRr5QAEe5gLT4Xb0lZGQnvzY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="446967803"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="446967803"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 12:43:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="889200532"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="889200532"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2023 12:42:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 12:42:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 12:42:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 12:42:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 12:42:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckYLJ6s9ikhPSlmoSPh0HiCJZTiD6umtAiCeXa5st1f+ldMY82RTwJi9qo/6UuwIYHYSjEgABHyOmmmc5OpWrgzz2AwGGxELKPQsHKG9TJH76jPL1X8JBvugGUYwSj1ppAPm81Z5GcbnLEPOQAEoowljCK7VZcFbf7pQD+ycbd74iVqK22QkjD3efwaMmXBDA5au4ycV7b0t6DCj/EZUdCVYV6TpMhwiNt9VLUuGhpUoZdyU6AEhAG67R9cRpAtAZxBSoUKOq6K6G9NvbQl5RTCQC/2TJIoUzwMnrd+CMb9aJ8FN72taQGRKswQWCWe1or8eC38MjCFHBkFrfKI8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRFFd4A6xGHNTFA4Jad5dPLntl21y6xqY4iYsbuFhW4=;
 b=aGhFRYadScmMSAyGfMeQ6cK8xt0AS3IQ3BQXfvkyhnr7UwI/uPxp9a+91AAxkXy8KeDdV7kOF0Ce2LLRNWLKLNM7OLcLsl2lhdv/UPsRzYK+Pdz8R6XSVb8RpbEo82OKvqWC09r5eTL9TOc172TjANf2xHKfn6Yy8Dr1raGDCi6p4/ZMHLaV7MKBEKfh86msZhU/jR4LmCGXGAiXlWojbEX25Z2MR1LdL+kDuvtohEaU6Wpd0OV5+NNHZaBWKNGoeq8uutsjpHCOwaT5g72cz+CWEPxFQB3weKvYCqiCT0Q7r6MMh2SbYM3OG+ABxiXBvvVQkS70i9akEptLsTqP1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA0PR11MB4686.namprd11.prod.outlook.com (2603:10b6:806:97::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 19:42:49 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 19:42:49 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 1/2] x86/mce: Disable preemption for CPER decoding
Thread-Topic: [PATCH 1/2] x86/mce: Disable preemption for CPER decoding
Thread-Index: AQHZpQwiSV5YEcM40EuivrL9zu2Y2a+W8n2QgAAPY4CAAAqHsIAAJ6WAgAAC79A=
Date:   Thu, 22 Jun 2023 19:42:49 +0000
Message-ID: <SJ1PR11MB60831A6E82329E1C53257F3EFC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230622131841.3153672-1-yazen.ghannam@amd.com>
 <20230622131841.3153672-2-yazen.ghannam@amd.com>
 <SJ1PR11MB6083664BCFC8047A5FE8F6A9FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <f03b6c61-1669-c03e-310c-cc1364cf30a8@amd.com>
 <SJ1PR11MB6083961DFCA3D90922824189FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <77d51e2f-cd1c-9c30-5bd5-42b1d583db53@amd.com>
In-Reply-To: <77d51e2f-cd1c-9c30-5bd5-42b1d583db53@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA0PR11MB4686:EE_
x-ms-office365-filtering-correlation-id: 3ad34dbb-ad4e-447f-b62c-08db7358dc62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4u0tXNfhWiMxLR6EJPVAZULa2hkFwZWPbTLNQjEVjlMD7ldxWqUovPEpT9hJGp2Y294deGbUqsyRzJZdgUT/ULZW94XjH82wCFstmZScbGyPvViG1j9EvbEU7oKeRsuHJUMVhDW7tsJlCaIeLY8BmqBQ0nMDcTKy57C5yq2GojBvb9B0qrGXAtR7PtwvTAb8wB1dJOU8E+LNonjJBmvpmzruaQrL4BbfXAGdAbt29uCcmFGHgSHEFYraQsv6eWienBFyRfbKQZyKzxyx+M/UgxM/nlyfaHRiLWQXekDpCj37Bwe7GRBavxJ6QmryuU4ws2/hegYsPNry3vaWMTLnTNkqHJTnWLRLeiu9lRpVRLKvunU57o+5+zpxnX3Vbz+yyhdSbQWqQ5sfLGsG8kkINV2mWLKsFe031z4ouI+cFmDDdnmRq9VIa/f93+7sL+ixh+U7sPk528SPT93pVnVoPExowpYEKb9MHkjQG0W5nmTSTe/tYXTMzVs9PoMKUNiDpy/nMx/is7fKk4DBKPxHSOmaV4WFzj0c6xDlQSHJ6NWuOZK+fWQhHG+l3GIoBY3GpXAe5GVbJuB2BVk06/gDY8hE40Hc/Z/F9apwHbDUcs4ORWdROTkdXUAPe2P9BPEk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199021)(66946007)(76116006)(66556008)(55016003)(4326008)(316002)(66476007)(66446008)(8936002)(6506007)(8676002)(9686003)(41300700001)(186003)(26005)(110136005)(54906003)(64756008)(71200400001)(7696005)(2906002)(4744005)(5660300002)(478600001)(52536014)(82960400001)(38070700005)(122000001)(38100700002)(83380400001)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OENYemgvZm1PSHB5UWFiVEtPQ2lPYjg4bHd3OXYxTEN1SHhwWU1zUjJqM1JO?=
 =?utf-8?B?V0pkSnE1U01UalZSNk90Z2hYTkp1UjFhOXBiQmp0Q1lzZll3VFlvMUNVVFV5?=
 =?utf-8?B?Y1lPSENaRmZSSWZqMkcrQllVS3FjdndPZTI3a0VBQ2dvUnQxemlYaGJjdTZm?=
 =?utf-8?B?V0crTEdOTkJwOVAxMkRRREpZWDVldWNxeVM1VWlURUk0MCtZSmw1Z1VTWjU0?=
 =?utf-8?B?UkNiYUZvMkZxNFVROGNSaWlSb0lnZGI5UXZ3dll3c3VHalROQ3RKdWpjMlRL?=
 =?utf-8?B?TlQrbGc1NVgydmVQRlFTbWZqL25TZm80eVByZnNJeDN3MzEvT2kvWGkrclJk?=
 =?utf-8?B?RlhjeURoeTloVHVNbmlUNjlPQzFiZlRFUUt6S1d2TFFhRnJDR2x3RjJlb3Nm?=
 =?utf-8?B?Z0ZDcGwwYnVUb2hERG1jeFdUTit2M1piYXVTcG9JRW5CVWdIR0tRaHcxV1hZ?=
 =?utf-8?B?b29HeWI2bE4rOHRoN1pMUmVsVnRyR00vSGYrZlkyaDVSRlVyZXR0aGQ0aDN5?=
 =?utf-8?B?c2NKaHNkMGRLcWhSYmlsSE9WZlF0bHFGZlRZSmFaSExLUjYrMzRSNVpZVVNk?=
 =?utf-8?B?dFA2R0V0Z1l1OXBYM3VTMnl4MEpSOXY5N09yejNXcDduTWFnTFdVeklCdmRI?=
 =?utf-8?B?b0VXcGowV2hEL21Cd0wyU2FqSWFtWk5GRWQ3NFBJUHJxTXVTRUloVjQvOG1I?=
 =?utf-8?B?cFNNLzlpK1dDNXNnbVV2UC90Zk1QbDB5V2dmZ3FVbThIOXB2SEw0UWRETWpF?=
 =?utf-8?B?aGkybWF4ZTRrTVA2U3BLV3plMGlzSWNGcHdmQWJSSm11VDNtenhmMzhENUh0?=
 =?utf-8?B?K0FvTmd4WW9CMXhmckxtMS9KZUxjZ1NjWUYxOWVwQ1hlb2NMS3c5d29LS0Va?=
 =?utf-8?B?M1IyVnBYS0Nqa2JtcnpqSlB2RGphTDVLcjRzYjNpZGZldWVDZWdJZGRyRFVw?=
 =?utf-8?B?OHJKWCsrNXlEWm0vMVpkYVlYckhmSzB6RXQ4NzMvTk93SWVCNVlRWHJ5VGNQ?=
 =?utf-8?B?aXBOdnl2Nlpaai9UOW13SmFUK1VSZkNkdFNXL0IzQ1pkaUU3VjBhbmNQazBp?=
 =?utf-8?B?L0o2eDF5Yy9tY3pQQ2hjdFQxZzNDenZDVTh3cVpRclV0QnFwYmVpMlBFb3o1?=
 =?utf-8?B?SXFpZlhYeW45L1g0UHNNQ1NmaG9iWHV6TEk0dWVKbUwzUUxyL1BuUHJqaGtK?=
 =?utf-8?B?bmNPWnZFYi8zbEFFTW8rTDA4a2pGS080ZHVONmU5Uk5Ed1k4dThsUXoyRExZ?=
 =?utf-8?B?a1YraCtQckNTajMvN1Rpa3FFeWFacVp1VlZsOXI1UFBtMGZUT0IxVFRzNVVm?=
 =?utf-8?B?S0ptak43YzZqcFM3cVNaNGVsSSsvQjB2VUtocnNxTDA1YWtTVUg2bEhibW5M?=
 =?utf-8?B?eHJoRWlWb3BkVXdvMzNtTU4xUUxwbm5xR0UwQUprMTR1UzhwL1dWQ0EvVlZJ?=
 =?utf-8?B?T0pXTGVuM0o5YkFIQmVsS3hYb3dKUFRYdGdRWkY1V0ZFRFRjMzA1T1Erdlk4?=
 =?utf-8?B?VnQyaUVBck5leXRyek1saGNVdFVHRkN6V3lTa1R6MndhRUFOY3VCelRMa290?=
 =?utf-8?B?WDRVNXFHVlpmRTFsZG5wd1hVQ0k5SXRMazN2aDVONzU5WFd5Q29JK0FZclNu?=
 =?utf-8?B?c1VVRzkvdFRWQk85TGRJbXpHcVRXbFZ1N0pyZWcvejMwKzNWbGhKMVRRWXpB?=
 =?utf-8?B?eGJDT1hXRlBsWExPMWs2QzFzd2FZSWZ5RGZDTkpzeDZFQnBjamZicWlwTEZ5?=
 =?utf-8?B?SzByQ1hTV29IamI2MXVkbUpGWWYrTFd4dllDdW5TdGtyTVNIdDYzRGZPQ2JK?=
 =?utf-8?B?b1Nrd0xWZ0NPVmF3eDVrMlhwMEVUMHJrdXBZV2w5NVZnSG1YbGtoOWZIK3kz?=
 =?utf-8?B?OFRrNFIxOS9oRUxURWphSWJwVkRLdE9jRXRuSWVWN3U2N1c5cU5kUkl6cmR6?=
 =?utf-8?B?UFhKV3Y4M0R2QjFYSEoweHZuT25CdUluWWt3bmJUNkNxb016RzJsdUQ4Y1pq?=
 =?utf-8?B?N29qdklVcGx3RVBYWlUwM2NiaHhCUFYrcnVYa2l0UDFLNW5QU0lhKzRXZWxj?=
 =?utf-8?B?dEkzVy9aZzJWUGZEOHo4NU1WZWNDY3hNR1B1TVo5SGUyc0J5QXhlT0dmNXJo?=
 =?utf-8?Q?Juik=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad34dbb-ad4e-447f-b62c-08db7358dc62
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 19:42:49.4265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iG8LxPyP2o0gKHdB1Mmp348dU/hPZ03Hm38JVesLckVhScRJ1HR2e9VqFKdwd35GqLy96DXI72vrnZJy+zFFsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4686
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

PiAyKSBTcGxpdCBtY2Vfc2V0dXAoKSBpbnRvIGdsb2JhbCBhbmQgcGVyX2NwdSBwYXJ0cy4gVGhl
IG1lbXNldCgpLCBjcHVpZCwgDQo+IGV0Yy4gd291bGQgYmUgZ2xvYmFsLCBhbmQgdGhlIGNwdV9k
YXRhKCkqIGFuZCByZG1zcigpIHdvdWxkIGJlIHBlcl9jcHUuDQoNClRoYXQgc291bmRzIGdvb2Qu
IFNvIGdsb2JhbCBpczoNCg0KICAgICAgICBtZW1zZXQobSwgMCwgc2l6ZW9mKHN0cnVjdCBtY2Up
KTsNCiAgICAgICAgLyogbmVlZCB0aGUgaW50ZXJuYWwgX18gdmVyc2lvbiB0byBhdm9pZCBkZWFk
bG9ja3MgKi8NCiAgICAgICAgbS0+dGltZSA9IF9fa3RpbWVfZ2V0X3JlYWxfc2Vjb25kcygpOw0K
ICAgICAgICBtLT5jcHV2ZW5kb3IgPSBib290X2NwdV9kYXRhLng4Nl92ZW5kb3I7DQogICAgICAg
IG0tPm1jZ2NhcCA9IF9fcmRtc3IoTVNSX0lBMzJfTUNHX0NBUCk7DQogICAgICAgIG0tPm1pY3Jv
Y29kZSA9IGJvb3RfY3B1X2RhdGEubWljcm9jb2RlOw0KICAgICAgICBtLT5jcHVpZCA9IGNwdWlk
X2VheCgxKTsNCg0KVGhvdWdoIHRoYXQgbGFzdCBvbmUgaXMgcGVyaGFwcyBwZXItY3B1IGlmIHlv
dSB3YW50IHRvIGFsbG93IGZvciBtaXhlZC1zdGVwcGluZyBzeXN0ZW1zLg0KUGVyaGFwcyBtLT50
aW1lIGFsc28/IFF1ZXN0aW9uYWJsZSB3aGV0aGVyIGl0IGlzIHVzZWZ1bCB0byBsb2cgdGltZSB0
aGlzIHJlY29yZA0Kd2FzIGNyZWF0ZWQsIHdoZW4gaXQgcmVmZXJzIHRvIHNvbWV0aGluZyBtdWNo
IGVhcmxpZXIgaW4gdGhlIEJFUlQgY2FzZS4NCg0KYW5kIHBlci1jcHUgaXM6DQoNCiAgICAgICAg
bS0+Y3B1ID0gbS0+ZXh0Y3B1ID0gc21wX3Byb2Nlc3Nvcl9pZCgpOw0KICAgICAgICBtLT5zb2Nr
ZXRpZCA9IGNwdV9kYXRhKG0tPmV4dGNwdSkucGh5c19wcm9jX2lkOw0KICAgICAgICBtLT5hcGlj
aWQgPSBjcHVfZGF0YShtLT5leHRjcHUpLmluaXRpYWxfYXBpY2lkOw0KICAgICAgICBtLT5wcGlu
ID0gY3B1X2RhdGEobS0+ZXh0Y3B1KS5wcGluOw0KDQo+IE9wdGlvbiAjMiBjYW4gYWxzbyBiZSB1
c2VkIGluIGFwZWlfbWNlX3JlcG9ydF9tZW1fZXJyb3IoKSwgSSB0aGluay4NCg0KQWdyZWVkLg0K
DQotVG9ueQ0K
