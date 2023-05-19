Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4B9709C40
	for <lists+linux-edac@lfdr.de>; Fri, 19 May 2023 18:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjESQRq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 19 May 2023 12:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjESQRp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 19 May 2023 12:17:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A67FDB;
        Fri, 19 May 2023 09:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684513063; x=1716049063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7GAWITP5QA4z8GsS1PZq7w/31+zb1WvWjSo+syGf0gk=;
  b=JzRYWElZFdAClRIKyb5FNpg8Y6zo8Q42ThiMggbniUqtv4aDqfhhRP//
   npo35eHWElLd6Q2QLHlDkwePLShvc912pChqegsA1CkTv0bVQRPPId42Y
   NJ7pj+Ea0/SRoL5NH/A+cdbxFOKdEKrUoK4fMqOGvqRz6zAnu7TCxBTZz
   4qd2DK/VG1CqIr37T+oOQCBqcKyMlCG9lnPj75EJJ5XTqrb4lD/fEdq9v
   a25RQZLROFO0yJQTtA+auzG4hKkIACdzGWFxrjLn5z//e/t9RuKiaHFO6
   7Lbt/wDHCE6dwnMqRLFwiJOmUdVjPgL0i2vwHBbxGPqd4Cvj//Gzj6hxD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="351256545"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="351256545"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 09:17:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="680093356"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="680093356"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 19 May 2023 09:17:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 09:17:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 09:17:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 09:17:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 19 May 2023 09:17:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYTGOgkvlFr+1csDglsTIaPdXzshj8vqcLorXHAsWLApPpdvX8iCZ+1WDFrgTYbsQuVpdZrRl4RawD8QCcQ7DfAqpoU25pnxEyuNF8899HbTTdF7gZ8mJHxvtSyZbO1dADoNF/nIsEIB7Y+ENJuXXEXyS49JslhdCIMmXL1I3sAynCYLkV6oyODCsCv1i9VkwLu2IwGs+nbqXy1NPQ0StqD/jrjOdo9bUYlYocbteAzAZiR5nX4pVDTyyouJgnmXPGcyydKWsHLHBik8NcUntk8KnBRgA25H7vQ3XPw93+WZkKrpliOUmlUroc9BBVApCkPluHRbli9j45lJrX8qaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GAWITP5QA4z8GsS1PZq7w/31+zb1WvWjSo+syGf0gk=;
 b=AvklyXa8iZCMcsvPL+ambWF8OCFqvqu1FT2blCuU/FPNS6yu9/g6ZMA87tqvq8H8VQtTDQdr+llvVqcTFAlJPIHu6RxmMIGP0hzeVgQgJ/a9DTG6rx5xtIO1As5yIKWuiUHA9NdvmIGlfy3Iqkk8F7R7kc+DKEFkC3i+x4WXB7PZDxO2pNK5C8dSSHsA/b59AvRtc+kHkHQDHVFcWO/znJd9tT1xGzrZuwyy/6CqVz5V1eztSJxeuheNLej8t48oHHD8FXvOhKXZKNb865Ol+qUYfb2UaM8grzkxzSVGGze6OJtEjFW9TruipHJpIv/rOh5BQYjk/XMW1+ylSdPsQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB5995.namprd11.prod.outlook.com (2603:10b6:8:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 16:17:33 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6387.029; Fri, 19 May 2023
 16:17:33 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "chu, jane" <jane.chu@oracle.com>
Subject: RE: [PATCH] x86/mce: set MCE_IN_KERNEL_COPYIN for all MC-Safe Copy
Thread-Topic: [PATCH] x86/mce: set MCE_IN_KERNEL_COPYIN for all MC-Safe Copy
Thread-Index: AQHZgVImNOtr/f0xT0mC0EpzAZOge69fVySAgAKAqHA=
Date:   Fri, 19 May 2023 16:17:33 +0000
Message-ID: <SJ1PR11MB6083194699B63B199A2B5199FC7C9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230508022233.13890-1-wangkefeng.wang@huawei.com>
 <d13b2730-bc20-3e32-a6c0-44c525ca9f0b@huawei.com>
In-Reply-To: <d13b2730-bc20-3e32-a6c0-44c525ca9f0b@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB5995:EE_
x-ms-office365-filtering-correlation-id: 65352881-92fd-426f-c993-08db58848d47
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bmJXmtyjyeT9ed7PHQh4INhnz8G2M35M8nYJAX55HqoNYws1k6o/+NblMvXYgwSIuZM8PWakXqkKfb2SeVmTWQvqEex1vPdB0ADkip1St4KqgfVO+UMO4VjmjuhPgnXkZA1DXxfaKe5tjV25L5UkTvwplNPmE4r7yFx3wutI8IhHqq3uoEcnl767TwENnBa8G1icWZ6GxjIvSMHlkHaFN2nkJGLaz4YCwBY9zlN/Z4R7pfyV7bUXZLox+eiZLGmZgSoEQuHy2/RdrbIUXIweefWBlCKV4D0n076ZDAPoqPBjbIIWLsTot1a+X/JEN8f0OmDwNjwJCIxUbzEM1MTpIJTjf3U9uLeOW0zteR4w+CPshvPTCz/oi/cH9KyFcY09PfYe1nuImY6fvvGTSrTJQhLB41E7E6KfCS8j3EpP1vPF6pXLMtLLpBDM+O9nkVdayczqR048YcvwdVjQhDtGE/sZ7ZXLYAowN46Hh3WkOmaKNNlzJU5PZSHoRHozPXcdJ8ja1wbwsBm/7TF5d2o1rE8xQrsZrTWVcqsp9WraBhElifW06mtJVJMhtkvJqV9ZYt4rWoB2I1Pjs2jK1wU0Jeeogb4d5UYH+FvSWF6/SzM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199021)(86362001)(9686003)(26005)(6506007)(966005)(83380400001)(38100700002)(122000001)(38070700005)(33656002)(82960400001)(186003)(55016003)(478600001)(110136005)(7416002)(54906003)(8676002)(2906002)(316002)(8936002)(41300700001)(5660300002)(52536014)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(4326008)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXF3MGltSHVNUFRrTlEvdFhBenJaWG1DRVJLRWU0MlN6cmFZN21oRVdETDFn?=
 =?utf-8?B?NUp1Q2Q5Mlh2U2xNU2pTbFN4ZGNaQXh3QVp2N3MxUUtSWTRBd1dPS3lidEQ3?=
 =?utf-8?B?TXExcFZndyt6RkR6RlRJeVdRZ0VYR2FMOVd6RU9mUG5XWnJiNThNdkJzT001?=
 =?utf-8?B?MWpBUVhpbDhHVjZaaFgwRGNLVXdTY280Zi9KMDlDY1RLMFJQK1pFNUNweVJj?=
 =?utf-8?B?WEE4TWF6cTRlMWlHWkFmN0d1d2RJSnJSM2NGOTVYR1UwWFRRQy9QVlUyNFk4?=
 =?utf-8?B?ZVY1bWZtTHNLNExKL0JIWExjODQrTCtuMU1hQ01LWHJOb3ZZanJMQmt1UmR1?=
 =?utf-8?B?aW5WRVFOUUZqc216VzM5ZFBMV3VEbW0rTy9PSVZwaVZBVjQrNURLTWoxVnFn?=
 =?utf-8?B?NmVYUHc0aS8wMTdINjBpbmZ3VEpGS2tjSDZaMjZpTEZCYUQ4RnRqWUJsTkhG?=
 =?utf-8?B?S1hNNERSaVc4QmhqWTFTak5CZ2g5cFc0bmx2WDk0dUxoaGVtMGtkQUpOZTMr?=
 =?utf-8?B?U3hRZ0dieHBUYjhlRTc2TlpoUTNrT0YrUGFjQ21hb1FtdGNxMjRBTSttdUph?=
 =?utf-8?B?cDBlSzFzQWo4R3RnYTBmUEYvRE55eGZkaTNLVVg4VlVrNVBaTlFJQ1Z3eHhm?=
 =?utf-8?B?dzhNUlRQU21SQm5LMXhldFptbFhxVGVBejd3T0dPb0hyYnlFNFI5dEF3UWo1?=
 =?utf-8?B?bzdEaERBdWJxd0UyekdSSXhMNTRrK25DcFF5Rm8yQnUzQUY3amtOZThiOFVC?=
 =?utf-8?B?MW5nVjZnbkxadXozcDBNMmVlNDZ2ZjVwQ1BweXBiakxFM3pVUnlWakE1d2NE?=
 =?utf-8?B?VzFBMFFnbWttTDIwRHlrZTNyMHY3bEFjU3F3bjU5T25LR1pJb25lVlhFdmhi?=
 =?utf-8?B?bUxJVjdDOXlrK0JqNmxzMjJjeWNucVBVM3JLOUp0cHYxMFdwcDZOWlpBV0pl?=
 =?utf-8?B?VEZVT0QzbjdjaURjcllaMXVMbXJPUEdaSEZJeklLYmxiZE9NaXZsRGlINGpF?=
 =?utf-8?B?VFU1N3JEV3FnR0pGV3J0MHVHR01xYTJpbktvSjUzRGw5UVlFL3hzVmhCZmpL?=
 =?utf-8?B?NFVMSWRzYkVOQTkwTWlkazFReUZJb2NMUGNTMURkeU4xRUdhNVErQXRSTGNO?=
 =?utf-8?B?d3lGWnBvMjJDWVh5N2ZkYzcwek5TQ05MRnFKajQ4ZGtkTGJ3NkZTRHpNV2Zl?=
 =?utf-8?B?bW5rMjI2ZmhZdkwvZHQ3cDJnZ3JXSWcyZmJkaVpJaXY3S2RDamVpMStVNFJE?=
 =?utf-8?B?NFJnZ1NCcm5oYW42K09yanc1RzlNeVFIODhBMmsxMUpPMnpOWnZ1RE5uZlhu?=
 =?utf-8?B?S2Rzb2xtdVJqNXRXbU13Qk90MHV5ZHJEcVpmK3JkejduUThtM1graFJTRWVJ?=
 =?utf-8?B?L2xwMG1sZTNtOGI4UmdVcXdadU0zR1l1RHRKQS9sVU00UjhCWmNhVzIzeFN3?=
 =?utf-8?B?WHE1bU5PaWRHZXZmQWlvODlGUEVmeWNJU3pVeTVZVVJPNXpyOUZBcDZUc3U5?=
 =?utf-8?B?UnFmdUJlclprVFdtbi9FcGdZdVlnSFN5MzMvTUcxbjVaT0puZ25nR3VpSmla?=
 =?utf-8?B?Mnh3Ty8ramFOVkRlNE4wcWZjMlNpaEtQVTREOXpvK1MvYVZmTjVBS1A5alFy?=
 =?utf-8?B?bElYMXFVN1pDeSt3eG45eWFHQ2YwcWFieUxKcWlkWHI2VWp0TXpFNHg4UCtK?=
 =?utf-8?B?V1FNUlpDc0pTblZ6Tkorc3hDVHBaNng5b0M3Y3FPRlBSdTFVak5IMFljbmlq?=
 =?utf-8?B?UThlYnY3NFJaME9ZVTRTdzhvbnNMYlJyZVhJczVxY3BSOFRyUVZaZ0VvRjd0?=
 =?utf-8?B?WEM1ckFhWUdGTUZ0eVFuY3RoQzVRZStFekd3SThVdUtDcUJ4cWxFUks5OFFR?=
 =?utf-8?B?VjZHNVIyZnNmOTNBNGN3NC80bEdTV3cwK3hCdGhtZWQyUG9WelBlQkd4cyt1?=
 =?utf-8?B?YlcvRS9vVzVsdTY0YTVLd1VGQkJmM0VtejZpTmVoVEpRTlBmYW9rZzh5TkE3?=
 =?utf-8?B?SVlrQXlhMW5wM0Z4UHd4QVhSR3VZODVLejY4ZHJYc0t6akw3SkpDSzgzV0pQ?=
 =?utf-8?B?dFljMVYzdnFEOXRBUi9vVUJ4Z3JhLzRRQ2lTM0src1Z2WFg4NGp3bUNmNXBY?=
 =?utf-8?Q?hVyw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65352881-92fd-426f-c993-08db58848d47
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 16:17:33.2146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X8ISYeVqcUWWsFuOJWixfdw+kfA+kVuf4RePiUTf+MxZoLgyxWSzRASGmerTjBZ5/FEEvXlLO8KwSnKi2gNdVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5995
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

PiBGb3Igbm93LCB0aGUgTUNFX0lOX0tFUk5FTF9DT1BZSU4gZmxhZyBpcyBvbmx5IHNldCBmb3Ig
RVhfVFlQRV9DT1BZDQo+IGFuZCBFWF9UWVBFX1VBQ0NFU1Mgd2hlbiBjb3B5IGZyb20gdXNlciwg
YW5kIGNvcnJ1cHRlZCBwYWdlIGlzDQo+IGlzb2xhdGVkIGluIHRoaXMgY2FzZSwgZm9yIE1DLXNh
ZmUgY29weSwgbWVtb3J5X2ZhaWx1cmUoKSBpcyBub3QNCj4gYWx3YXlzIGNhbGxlZCwgc29tZSBw
bGFjZXMsIGxpa2UgX193cF9wYWdlX2NvcHlfdXNlciwgY29weV9zdWJwYWdlLA0KPiBjb3B5X3Vz
ZXJfZ2lnYW50aWNfcGFnZSBhbmQga3NtX21pZ2h0X25lZWRfdG9fY29weSBtYW51YWxseSBjYWxs
DQo+IG1lbW9yeV9mYWlsdXJlX3F1ZXVlKCkgdG8gY29wZSB3aXRoIHN1Y2ggdW5oYW5kbGVkIGVy
cm9yIHBhZ2VzLA0KPiByZWNlbnRseSBjb3JlZHVtcCBod3Bvc2lvbiByZWNvdmVyeSBzdXBwb3J0
WzFdIGlzIGFza2VkIHRvIGRvIHRoZQ0KPiBzYW1lIHRoaW5nLCBhbmQgdGhlcmUgYXJlIHNvbWUg
b3RoZXIgYWxyZWFkeSBleGlzdGVkIE1DLXNhZmUgY29weQ0KPiBzY2VuYXJpb3MsIGVnLCBudmRp
bW0sIGRtLXdyaXRlY2FjaGUsIGRheCwgd2hpY2ggaGFzIHNpbWlsYXIgaXNzdWUuDQo+IA0KPiBU
aGUgYmVzdCB3YXkgdG8gZml4IHRoZW0gaXMgc2V0IE1DRV9JTl9LRVJORUxfQ09QWUlOIHRvIE1D
RV9TQUZFDQo+IGV4Y2VwdGlvbiwgdGhlbiBraWxsX21lX25ldmVyKCkgd2lsbCBiZSBxdWV1ZWQg
dG8gY2FsbCBtZW1vcnlfZmFpbHVyZSgpDQo+IGluIGRvX21hY2hpbmVfY2hlY2soKSB0byBpc29s
YXRlIGNvcnJ1cHRlZCBwYWdlLCB3aGljaCBhdm9pZCBjYWxsaW5nDQo+IG1lbW9yeV9mYWlsdXJl
X3F1ZXVlKCkgYWZ0ZXIgZXZlcnkgTUMtc2FmZSBjb3B5IHJldHVybi4NCj4gDQo+IFsxXSBodHRw
czovL2xrbWwua2VybmVsLm9yZy9yLzIwMjMwNDE3MDQ1MzIzLjExMDU0LTEtd2FuZ2tlZmVuZy53
YW5nQGh1YXdlaS5jb20NCg0KSXMgdGhpcyBwYXRjaCBpbiBhZGRpdGlvbiB0bywgb3IgaW5zdGVh
ZCBvZiwgdGhlIGVhcmxpZXIgY29yZSBkdW1wIHBhdGNoPw0KDQpJJ2QgbGlrZSB0byBydW4gc29t
ZSB0ZXN0cy4gQ2FuIHlvdSBwb2ludCBtZSBhIHRoZSBwcmVjaXNlIHNldCBvZiBwYXRjaGVzDQp0
aGF0IEkgc2hvdWxkIGFwcGx5IHBsZWFzZT8NCg0KLVRvbnkNCiANCg==
