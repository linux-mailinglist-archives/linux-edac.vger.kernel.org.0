Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED98661DF7
	for <lists+linux-edac@lfdr.de>; Mon,  9 Jan 2023 05:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjAIEpb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 8 Jan 2023 23:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjAIEpa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 8 Jan 2023 23:45:30 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF925139;
        Sun,  8 Jan 2023 20:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673239529; x=1704775529;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gLHFuOqjDssXIEKjhRP7o3SaPxycGt7/8u3zQr4XasY=;
  b=OSDcX6To6gpZMFKvnMzHFDqqQ7pmeHBM7JVbVKKv4cfmMv+hsGCWg0Yp
   4XVlf553n80QQ/BW1lBzSZ/soSmgNajHd14Oetqdt/ElXy4cnDNEG99E/
   S5ueKLfSW2iws0On2OGwTcmTkXg7cEf/bea0SxWkfUDeKuOQUUUqUeAC/
   cTbirV3UpZXe06hPKYEIBCyl79+oZ3/d3ixHB814lcGVlDMZ6Yq9kKC2w
   1W0gMGQJjQjYPycFkb1b+Me0bF6SmPwhqj4C9KShd5q1bRV6kDHTby361
   O6O3w4j9dauBky3KAumdn/akZs9Ap7wbjFdhlmQy385SmvjOnm7MsK5Ul
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="324039877"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="324039877"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 20:45:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="780565562"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="780565562"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 08 Jan 2023 20:45:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 8 Jan 2023 20:45:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 8 Jan 2023 20:45:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 8 Jan 2023 20:45:28 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 8 Jan 2023 20:45:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNbgGoh40QimJ/kl7OeYu7WraEQhU5LU4OhwG/cRhwjEAEKHT6+wPmVuf3QPWbKIHZIn/LzykCe14Hsxb7lo8lgjHIbV8XUvTe6JIGVyOo2gc2Z7kpPeEOSfv4L1qe/7iEgI+oAEhkasu5eKEKBUrK51jKMFZf8lod1V6xfT6ATtpPwbGDYuHBBpoB6XhD80Q1nqXYNdp7FSShOGYHbXA5KvuqBxxBpIplEg7Ma1QnlLzcytlA++EsKEM6Ix2aj4NWDueP00Q7FPkm/LAcMyE8nJHyJkUZd9RwB0x3Hrko6Vzi6jS158PWvkdRQ6/0+ydPv5dMLOvoKanSErBNxp8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLHFuOqjDssXIEKjhRP7o3SaPxycGt7/8u3zQr4XasY=;
 b=ldo4X7birXEpgsrv04iW1Ogm8ieRzWuZUqbjZc0FjdkEFyrP1RFNrdAmUsuB74x+lfAFUv1hTmOQjglCJqlC9/4FFGjuc7UH0z7uTLghHB/VMh6qnel18Hc8NIwI5C1UMG9aQkTaPfw1JiUWp4CTsN7tK5MYhc0fKzvH2RXeEHeN0eJzBQJHFfct8QmErv8ArbHH7P2aTA0mxnfLgSBSybHbIlgGEl0AM49BtYodI9cyhjWU34FR6t8Xn4ySg6BEYC6Ue7dnKoEZEO56mLUyhg+bpvGA3OHahOT7vOkF7qGIeFjmZqHZrzp2DxzsRfHhJ625SrK1l3tlO0gagrpOVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 04:45:26 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%6]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 04:45:26 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: RE: [PATCH] mce: fix missing stack-dumping in mce_panic()
Thread-Topic: [PATCH] mce: fix missing stack-dumping in mce_panic()
Thread-Index: AQHZBiod8rBYaoP1F0+0JAoGaAcDUa5aqxswgADD7ACAKX1GgIAACwCAgAAE7YCAANthAIAHiZWQgAN23gCAAQX3gIAAlLEAgAKUQSCAAI1bAIAAJ76g
Date:   Mon, 9 Jan 2023 04:45:26 +0000
Message-ID: <SJ1PR11MB6083469C1A029CE6C121DF26FCFE9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221202163728.392509-1-linmiaohe@huawei.com>
 <SJ1PR11MB60830CE8C3F79C9531C8567AFC179@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <5cf492bf-9807-a091-6ac2-a953fce276da@huawei.com> <Y61/+V47qH/8OVxp@zn.tnic>
 <1e97c11d-99b6-c06f-b67f-c56ba6653d27@huawei.com> <Y62NVThhnGtnj71u@zn.tnic>
 <276c9e6b-d647-6f7f-7bd1-c1f45ca23261@huawei.com>
 <SJ1PR11MB60831AB2202FF0C3CF99EF1DFCF49@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <b63056f9-0709-736b-ea5b-5e903410cb1d@huawei.com>
 <SJ1PR11MB608346981E53D14BF37788FCFCFB9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <c89697aa-64c4-d65f-5f65-aa94c1de7e29@huawei.com>
 <SJ1PR11MB60839243ADBEA755203CC352FCF99@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <1e1bfb2a-5e20-626f-97f7-5ff4cf3d4d51@huawei.com>
In-Reply-To: <1e1bfb2a-5e20-626f-97f7-5ff4cf3d4d51@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB7424:EE_
x-ms-office365-filtering-correlation-id: d8dc872d-58a6-446a-8105-08daf1fc53a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z6/tGdPpTurT0lti8pbNG8YHanVu2CBO2fhvqmuBvI5b3fAZG51645ALa1O4J1yhmzaSXFJcW3LaRnS9Yfdr7tz7ow+XYGLxMQd3ndwN5a6+Z3w/naH7WNzwisioYDR4aLfeBNKzrgpls4UKJyoNSr6ugR6rtH4SpKyKhFtniMecg4TqiZ2uSKquvku436tAk9/kQOrgqf54D1fyxLx6emYwPhATLnFFZlT1lxZao98JCXczz5pepnXyxkEfHhV1eTkhYTwMV5/PAFbdY8ELvLPV6AVxyd/15prYolD2kXa/gv+8Ar7JYKqfDc3SycfW6kfUDZhXWnauIdMVsmb2pXA1jYbGoBHiA8v4CKH4CkIG6Z32D/4Ni2BBKEPKqtRbK0+H9ZSJ9ErPHQWcovPtb+eGLULiaRYyv/S8CycAaveCzdgdOvuYOSD4qNkI3fbxtBL3bbY0APpzhbBVzHetbf5Nx4KC/A/8miyUD6emXnxZHHKWN07G3aP+CX/XaVgOgTXj/hftdw6U9p+7XH7HlFXkB3liCxMFc0nLdHyN+zyxMcQzlJpgW28CjDziICLZcnqVdWaXFNHh8rmRR0GBwqxmGcKqxM5GRhstSf1fkliUStUtLoeWFoChnSLfU8zUf+fYmEybhtn1uNtSr1dz69u0HAay0ymJIbCto5q68GjOmtUX98TzqobnJ9KlVLqqzq5F3iDiBTYrkA7pgJDaqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199015)(33656002)(4744005)(316002)(5660300002)(71200400001)(7696005)(26005)(186003)(9686003)(478600001)(41300700001)(4326008)(6916009)(66556008)(66446008)(54906003)(64756008)(66946007)(76116006)(66476007)(8676002)(8936002)(52536014)(83380400001)(38070700005)(86362001)(55016003)(6506007)(122000001)(82960400001)(38100700002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDF0NTBTM2lGZEQ1Ry9ncEhEWWxxUkJHd01JcHJkWGZmN0V0djlZa0dwMVBG?=
 =?utf-8?B?NjVYMEFMUm5KQmxCMWxSaGlMWk11RXVUajc0NlYyUjBCZVRZajlKd3Y1REg5?=
 =?utf-8?B?WGR2emhqQXdkaElOVXpZUkNBK094Tm5xMC9Cc2xqbjEwMFUyNTh2bmtDdHZQ?=
 =?utf-8?B?ZmtqVTFWdW8yalNXd0lHY1B2YXFzUUxDUWx6Vk0wejhraEN3TUVBU3VkaHc1?=
 =?utf-8?B?eVdyUHRwT0xtcW9ydElDQjFYQ1g1MElVK2xMN3A5elV4NWo5VTBYUlBrQVc3?=
 =?utf-8?B?dnpqczRLNXV2T0d3YUlFZjhaNDR4QnlvVmlHaFJVTUE5Q1RDOFFiZ3JjL2pL?=
 =?utf-8?B?QjBjVlBtYmhhNk11UzlBcmJORmNoazZ2aWM5SFFrK1lmdnRJczErWmpXcWs2?=
 =?utf-8?B?emdWQlIrUFZwTVhWUGIyM3V4NjBzNVhCc01qTExueTQ0QUZJQlZZUEo5VXgx?=
 =?utf-8?B?Y1oxeThyNExKTkRXWTZVM2YzS2l3QVhob2JIdmRXS0dZSS9EM2N5dFpaNGVs?=
 =?utf-8?B?VElOSGtLcVZmLzFJYW1XK1NsajR1cXhsSXczdUZxVE9zRFVkVllveHZDZGJZ?=
 =?utf-8?B?a2JORm9CNk8rZG5IYjZCcytNbGo3VFNTODhadkxYQjFHZFN1RkpLUlYwSlhh?=
 =?utf-8?B?VFo2SXI1NEQwaTRZODRYRmYySWhiMWxFM0lkaHVwbnVLRzVHVlIyZEpRdm9D?=
 =?utf-8?B?YWpVVlk0TmwycytUbForNU1DU29MbnBsdlJDb3hiUzMrbWg5dkU1blo5Tjdq?=
 =?utf-8?B?MktsM0wwT2pIeWpnN1Q0K3NBRnJqK2VRUjhMRUF5aGJacDZZYlJWejByWCtj?=
 =?utf-8?B?UTBuVnVMRW1jUHZRNlhwTnZGSncxK2xIODNlVUhSM1o4VGRuYzR0QkRsd2Vy?=
 =?utf-8?B?d0J3b0txYXZadjd3akNaUXNTVndWS2NCa3lXMGNBUTVpRXNNdGVTMElBZVB2?=
 =?utf-8?B?RlNCZnUvQ1lrdWhHTGE0ZG4xY3hqLzRDbVkyOWpScjl2NTk3V2sycG5naGM5?=
 =?utf-8?B?dHlOMVlKcHAyMVZzcHNjd2d1Y0QyWmgrdFZYN2ZiUytuS1NpZUExd2FybGdr?=
 =?utf-8?B?MUgxZzIyVk45ZG5kcTdYcXA5MmRsUGIvQTZzS1FIMythYnVXS2dGSTRKSytM?=
 =?utf-8?B?MXIrSjhqMThFTTNvQVNhN3U4VmpQK0FUc2lvMWlFT2svbDhjZnZnRWlXeXlW?=
 =?utf-8?B?cFphRmZqME1UaHJVdVpTb3FPdTNCNk1LOGpwd0N1VENsT2hlUGxkeWhUVXdw?=
 =?utf-8?B?SUhtQmFZVm8wMjJ2Zml0QW9YQTM4Z250UStPOXFJcTIyVEM4Z3p3cHhkQnh5?=
 =?utf-8?B?TVRVMGFJaHRIQmhpU3lzSjRIMzBLdWluT3ZqcXI4NmZkdklYeFBzaXJsb0ZO?=
 =?utf-8?B?NlNGbGtOYU5uV085VkZVZXBTMVBPWjREenhUWEdwMFpJNzdPVzNmemhBR1dl?=
 =?utf-8?B?YXVDTTVZdFJpbjc4ZXh6dEUybEJ5c2xuVlp6VHNOeTNhYmJ1eWdQNmVSWTk4?=
 =?utf-8?B?dVZvMm9kcndyYzRMUFAvR3RMbnZpTThrQm5kSnpqejl0NVdtcjQwYUpIZytz?=
 =?utf-8?B?V1Myd3BTeng0VEN0c2k2TlA0MmFyc3c5VnpJVG9YYnBSVGFoSVBzVmNVMGls?=
 =?utf-8?B?S2k4cFlwMHBjK0dBcmZGU1JVbzNsRmJCNCtENFhSdG5OWStqY2dDWElRRkVL?=
 =?utf-8?B?UUlWOTlIUmNsT2J2QWtIZ3llRzk1Y2tDSHZ5ZzF6QXpSOTJoNEtGRndmTTRL?=
 =?utf-8?B?bngxeGRueDBaTm41WlpzcVJkNHIvMHVtY0xUelFMMmlWOW91VEcxbnVZYWdk?=
 =?utf-8?B?L0p3ajVwRzliY3J4UEZyeU9DY0RPSDFKVEZBRlV6NndDa0J6NDFSMFlIVFRP?=
 =?utf-8?B?NmtvSEtrb3VueWUzcXo1SlBiUjczS1VhUnIxOGVCeHZUalpjQ3NENVNLeUNI?=
 =?utf-8?B?dkRRRkZYdWZ1Mk81Qy8zVTBVc3NMdDhYMFM4Y1VrOTZQTkF2NUdQQ3lGaWFO?=
 =?utf-8?B?cko3dmp2TzhScnF4MjFjamRGa3FoWGRDZy90dTFaQW9GN3RWOTRMeXFBM0pO?=
 =?utf-8?B?WmMvRlhJOUU3bXN2WGMxa0ViT0IxbUtHa3pUNGQ4WTJhTEI1elBVZk1CM3h3?=
 =?utf-8?Q?1ok0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dc872d-58a6-446a-8105-08daf1fc53a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 04:45:26.3220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sghtMyY/psDKY3D14wezSGN7D9HI0tHVjmZ9LWnLyzv5pZIag0mbG2WvKYaKk1arWcwxQYsUhjLpPZTdsii0Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7424
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Pj4gTWF5YmUgdGhlbiBJIGNhbiBsb29rIGF0IHNvbWUgd2F5IHRvIHN1cHByZXNzIHRoZSBvb3Bz
IGR1bXAgZm9yIHRoZSAidXNlbGVzcyINCj4+IGNhc2VzPyBPciBwZXJoYXBzIGF0IGxlYXN0IGFk
ZCBhbiBleHRyYSBtZXNzYWdlIHRoYXQgc3RhY2sgZHVtcHMgZnJvbSBhcmJpdHJhcnkNCj4+IG1h
Y2hpbmUgY2hlY2tzIGFyZSByYXJlbHkgdXNlZnVsLg0KPg0KPiBJTUhPIHRoZSB1c2VyIHdpbGwg
YWx3YXlzIGV4cGVjdCBhIHN0YWNrIGR1bXAgd2hlbiBzeXN0ZW0gcGFuaWMuIEknbSBhZnJhaWQg
dGhhdCBpZiB0aGVzZQ0KPiAidXNlbGVzcyIgY2FzZXMgYXJlIGVsaW1pbmF0ZWQsIGl0IHdpbGwg
Y2F1c2UgdXNlciBjb25mdXNlZCBhbmQgdHJ5aW5nIHRvIGZpbmQgd2hhdCBlYXRzDQo+IHRoZSBz
dGFjayBkdW1wPw0KDQpXaGF0IGFib3V0IHRoZSAiZXh0cmEgbWVzc2FnZSIgb3B0aW9uPyAgQWx3
YXlzIHByaW50IHRoZSBmdWxsIG9vcHMuIGJ1dCBmb3Igb25lcyBmcm9tDQptY2VfcGFuaWMoKSBh
cnJhbmdlIHNvbWVob3cgdG8gYWRkIGFuIGV4dHJhIGJpdCBvZiBoZWxwZnVsIHRleHQuIFNvbWV0
aGluZyBsaWtlIHRoaXM6DQoNCjEpIEZvciBwb2lzb24gY29uc3VtcHRpb24gaW4ga2VybmVsIGNv
ZGU6DQoNCiJUaGUgcmVhc29uIGZvciB0aGlzIHBhbmljIGlzIGNvbnN1bXB0aW9uIG9mIHBvaXNv
bmVkIGRhdGEgYnkgdGhlIGtlcm5lbCINCg0KMikgRm9yIHRoZSBnZW5lcmFsIG1hY2hpbmUgY2hl
Y2sgY2FzZToNCg0KIlRoZSByZWFzb24gZm9yIHRoaXMgcGFuaWMgaXMgYSBoYXJkd2FyZSBkZXRl
Y3RlZCBlcnJvciByZXBvcnRlZCBhcyBhIG1hY2hpbmUgY2hlY2suDQogTm90ZSB0aGF0IHRoZSBz
dGFjayBhbmQgcmVnaXN0ZXIgZHVtcHMgYXJlIGxpa2VseSB1c2VsZXNzIHRvIGRpYWdub3NlIHRo
ZSByb290IGNhdXNlDQogb2YgdGhpcyBwYW5pYy4iDQoNCi1Ub255DQo=
