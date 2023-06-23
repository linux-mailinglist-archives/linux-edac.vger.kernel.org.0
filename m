Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F0A73BBD9
	for <lists+linux-edac@lfdr.de>; Fri, 23 Jun 2023 17:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjFWPke (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Jun 2023 11:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjFWPkd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 23 Jun 2023 11:40:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C146E6D;
        Fri, 23 Jun 2023 08:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687534831; x=1719070831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fqzih54wQUOx7CiPSlaLDZAGMVLQEgyROZXcYCNo9mk=;
  b=OO3XdsqVgLnZDZ7tATd6IqSmSRMiqJAgFHJADnLODkkWb7Ycq/milsoi
   NvIz2LRHzQ5tYBvEXd0dcq/cqMrFqG6FsgnmdwytHl493aQ3O7VVvT3aP
   nD5BBrkG6Y/RayDok+5SEA24ar5KvdGebKUhd2lb+HhErT+cRXr6Sb4oV
   0LRKEpaxoo/yB2s4pTOv3kXimjqITF3az7oYEivO5GtSzSo8rM/KJr3Ms
   M/haa60tMxs57vCFk+/rJE4RzqQAclLK07XYgxkbd1zwiaBs9D0TuhZD8
   chZO7wShnvjSXzfBE6CJq6KqcFG2FD9FIa+3BgBX1YI3XsBmA7l6eSWBS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="345548165"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="345548165"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 08:40:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="785373555"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="785373555"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jun 2023 08:40:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 08:40:29 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 08:40:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 23 Jun 2023 08:40:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 08:40:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtD1Eqit5K4oe3B7xXo6Sucg2EVHTwfpF43m0j3WCXfrYa0mdJIKO2CuDbHhH6X5HUCoj2gg2uMUFr90W0t7Zib6nCC1hVgMtN73zyB4oldmfHZcaJyUXNg0ce91/OVUtBS+H3hJUeiklIzsgQhIzgPkOTwKD8/+9Xb7qTS4Drclm01mPagwJ1tSqOIdx4iDqCwXyz41Kbvxwvxm3gO38BXDyWgM4dXjObkW9s42oNsbcos+tE/7mwWeqX94L/boOx6hbSJh9T0U9SJbBUx6U0apJLO+xPRNpdvXnQ3M3gGyzdFk4tbSDh7UQoMUnxvIWqeHGGU3rgCxnUaxkLcPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fqzih54wQUOx7CiPSlaLDZAGMVLQEgyROZXcYCNo9mk=;
 b=Pak835RVMQ1VpkRnepI3JENTGZbqCznjHQ6xCI/04gLESn1aWlNWV3436LaZLFqfO67/YQ+A9zwQ1Zuy6dIVLZn4eJH9zG+DFcbkNyU3etWZYwmWybpENczCu2QT498/Bs9039p8ELfXAK2Oq9eM1zwfacwu8zfGRmt81XhfbHX6ECpJ7nSpeI5/Qke0lqPiaQ9i0cs2yMhSjHRKpP7V88ZRtogU95n9MIVnNJRlthTrAWmgM+6aPM5n6MqBMk4+uRzeCNA8Gq/EEffmjRRHMs58J18+vn1r/ObL8pv/Vo2x0JW88d7u37csaDoYQv9g/DGU1lJA7TlQvrNa3WDY3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MN0PR11MB6057.namprd11.prod.outlook.com (2603:10b6:208:375::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 15:40:26 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 15:40:26 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v6 2/4] x86/mce: Add per-bank CMCI storm mitigation
Thread-Topic: [PATCH v6 2/4] x86/mce: Add per-bank CMCI storm mitigation
Thread-Index: AQHZoIBQwPd49+1/f0Wq5vLaOwdIZK+YVgAAgAA6nIA=
Date:   Fri, 23 Jun 2023 15:40:25 +0000
Message-ID: <SJ1PR11MB6083EA4CED8706C77622AAF2FC23A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230411173841.70491-1-tony.luck@intel.com>
 <20230616182744.17632-1-tony.luck@intel.com>
 <20230616182744.17632-3-tony.luck@intel.com>
 <20230623120904.GAZJWLYMP0XxIr5k7s@fat_crate.local>
In-Reply-To: <20230623120904.GAZJWLYMP0XxIr5k7s@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MN0PR11MB6057:EE_
x-ms-office365-filtering-correlation-id: 6fa9ef00-e169-494f-689e-08db74002a22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iMn0kLFnkh5167NakdZ3oZgExuzH0LnY5Rl7HJQJsxjhWrH2RR5t6tnlPCI2b3fGF6m5m9a0IMQm7rDgoTtfi6jboRi+F6QINT4dxP37dLpkKKocolb/J2sPQh/9nNfv3wK1zp1JbhjhSKeLTqCsUZ2iBt5TAeUYXuc7/qakqBORSIWfS7EZeT5aZ7Oqd6f8rZHPMZ5IBkeYaBF1o4zXsoen4KmscJlk9en3Dj1brhVdUsnoCgFUCbj+hY4fif5gbUyCW1IRQY48f29DqFappNHbcJnOnZEP9/ZzrC1Pojeyi81O3i4nSCPM5Wc6yx+DhsZKy0T5e4AwrcMnrvAx0DSG9UtiqYlJiX4aCLTjxpeXsA++Ba2phcwdzBWFGmXEMZsZvHB7V/aXcWoNdmYWHZHytK1dtA3IYfuZSaC9GSZof/q6k4Ng4YUT2vWuMCXQn9F7yI1PWLPzQSZoq3PyS7iTm6Vx50wo+r+EIv8GtTIic5T7EycPKiehyVt+uHY8o78KTOtLK6kRGmSl5G9h0Z8hr8QUD/a5aZX6qJHjUcojS/lJGD1wPnAl0GBV3jFKXB84xWgEzACLiHce02NA5Nt+eomzyzqPrjv5DPAFWKAw4jv5Y1asBUpRRCl30Lup
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(82960400001)(122000001)(38070700005)(55016003)(38100700002)(316002)(71200400001)(66946007)(66556008)(66476007)(66446008)(8676002)(4326008)(64756008)(7696005)(41300700001)(8936002)(6916009)(54906003)(4744005)(76116006)(478600001)(2906002)(26005)(186003)(9686003)(5660300002)(52536014)(6506007)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1RzRnRKeGtNRTdhNXoyTEg4VStKZ0Y5MEtGQ3h2bDNxTE16YmZ0ajBOYkNO?=
 =?utf-8?B?VldjNVViVUk1WExiM3hQREtBSUloZExHQjBwanlxRDZQUW01UVpndmhrU3dt?=
 =?utf-8?B?TllKeFUrQWpiQkhxZWlSU3dkTm4wcmU2enVrYW1sdytGZmRROGk4TmFPNTkz?=
 =?utf-8?B?RHZJakV6VTE4QnZaQ3MxT21hNWZ3dS9wb1dNSEJSYzRRSE1kaUoxV2Z1eFZn?=
 =?utf-8?B?RllsVFJFZGY5MktYeDBsbUM2RWpZT0Z1SVFNVjFBUDFzTzNHYzJWT29rTVhK?=
 =?utf-8?B?c3ErWmZkdzFLVFRoOGlvanBiZG4yaFQyelZDZVhjYW80YlBOdFZzdndNVGpC?=
 =?utf-8?B?a2FhMlo2RnFlUzRjV2VkRk1oR2Zsdi9XTXVjcDRlSS9lTWgyZnZhdk5iUHF2?=
 =?utf-8?B?a1hyWGV2YmdUb1FJb2E0cTkzN0c5RWZCWjAxWERwaWVieWJVTU1KV2pERGpO?=
 =?utf-8?B?bFhUcGh5VVRaaEJMWG5XbmRtblZtZ0lRUzJVREVQSjJmN0pZaUJoL3J2am1S?=
 =?utf-8?B?RTQ1ZUlWakh1YngwMEwvZkhQUWlpNkZzSklacVc3UTFvTzJzd1M0bkRzN08r?=
 =?utf-8?B?NEo3WUoyR3dzS21NaWtKenIxR0hJQjd0YzBFQ0N1TGY5OGluM1VEMDFUMHpF?=
 =?utf-8?B?ZWFrelVpdGRXbUtyRGxOdHJxVG8xUkFMRDY3QmZ0QWR6eHlkQmUwS093eWlp?=
 =?utf-8?B?d25qY3NDbWM1MGVScUxQd2hhVzBCRXZXNWxIY0t4dFIzazJGT2IvNFpLZmZ2?=
 =?utf-8?B?YlZ5dXFURVBtZVowM0tnZFMxV05nenE2d1cyQ2oyam5oRFZyTnVmNUp3WGw1?=
 =?utf-8?B?WjEyVTE3YlBwVnRHMHpnWVdvYmlRK05GUFlWc1VJLy9jYUw2d3JNN25JUW9w?=
 =?utf-8?B?K21ualhyZWhOc0FVOEFVc1dpaFBYLy9wblh0cXF4N2NobHdFSEhWNVBTQ0M1?=
 =?utf-8?B?MXFKUVVKQlhtNWNHSzIxU1Z3a0JhNC92WS9uQnhSMkVKcFM5SmVHUmw3K0Ru?=
 =?utf-8?B?KzI5TlpZa0lEQURsM2JHQzhHUjJiWnFQRDYvS2kzTjc2ckhZSmVBTzNRQ1BK?=
 =?utf-8?B?cXppRjZYWnp5emhuT1VXYm5ZZmRkZS9JY2tWUFJ6VU8yQlgwYkpIWUx3ZmRP?=
 =?utf-8?B?dlp0NktEWERBeENMNlZ4cklXSFZhYWZnZUd3cERiN21UeWZ0MDFWZ1IvUGho?=
 =?utf-8?B?cG1EczI2NUx1a0NwK1BNMzJJQVFpS3B1MjNXejdEZ1VXdlJaSm1WY2FaOXdF?=
 =?utf-8?B?STk4ZjJSckFYMjNZVFprcll0Y2h0TTdQNlhSdDBlMlQxV0hXTmZ1ODZDYXB2?=
 =?utf-8?B?czFmc2ZwWHJvQmRtQlZOZWZpaG8xMTJmN2hCbXlPRlRicGZqTWR0Q2kwTTlx?=
 =?utf-8?B?cmw0a0FmZTVxek9TRGo2bHg5RTlBUWFVSlM5cTdna0ZBZjduNDhpZVpwUTZh?=
 =?utf-8?B?RUxyN1VqYXE3NGhtUG91bC81ZmdLS0JTQVBKU1JLZlh6dU8zSnB3NWxocVND?=
 =?utf-8?B?SVZXdkRLZ1EyeEpFcnd5bjdLTkFiL2l5bXluTmVLR2RSLytZR25oaGFOeGFH?=
 =?utf-8?B?S3prTXBkK0ZZWFZmbzdHREh4YmJGNHppUTBINnRhOUo4a1pvbStjdHp1cDZV?=
 =?utf-8?B?WG5JZzh6K2JrRXRlM3hJLzJlYmhrZnRwR0xVdFZQVytBYkZIZ1VzVVRQa1Ri?=
 =?utf-8?B?RjhyOUdDWlpyQ1d1bDlJOU1ob0VFT2dXTFpTSXpwNXpocHlxUUdtR2cxdStN?=
 =?utf-8?B?bkZINHZ1d1hLVjFDQlA3KytUaEhjYUhCREVCRzR3WDV4NlNoQWNndms4cGVN?=
 =?utf-8?B?T1oxM05mRnNGR1E1K2c0Rm1SUjVWeEJYMCsveGFMODdoQTh0dEhMYnZWRHZV?=
 =?utf-8?B?Q04remtUK3RXZ1ZnQlRxWGZyRUI4cGpyLzVDalpybmJXUVh3NFp4bVN2ZzQv?=
 =?utf-8?B?eDdCUkZ1SkNXQzZDTWQ1QnRyNWpqSkxaY2ZMNHlWSUdxNWd4K0hOcjRzSDZX?=
 =?utf-8?B?V3hIUS9oUmIvVGhiTFNic3gxOEhXVy9kWi94NUlIb1RUeUJjMytQTThLaVA2?=
 =?utf-8?B?cjYrUG0yRXNZbEkyNm13bjlOSDlaeWhqSEZRRHYwRk9wUHlTNERYMHlCdnFT?=
 =?utf-8?Q?OWkE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa9ef00-e169-494f-689e-08db74002a22
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 15:40:25.8504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SVuvIeAC1eXJImr79Kc222UecejEljAqPekl3n8ezI408AcByYHxNGnIgIT4vW0YtDNQnhoJFce7K+AqYPpesA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6057
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

VGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQo+IFdoaWNoIG1lYW5zLCBzaW5jZSB0aG9zZSBhcmUg
dXNlZCBieSBib3RoLCB0aGUgY29uZnVzaW5nICJjbWNpIiBzaG91bGQNCj4gbm90IGJlIGluIHRo
ZSBuYW1lcy4NCj4NCj4gQW5kIHdoaWNoIGFsc28gbWVhbnMsIHRob3NlIHNob3VsZCBiZSBzdGF0
aWMgYW5kIHByaXZhdGUgdG8gbWNlL2NvcmUuYy4NCj4gQnV0IEknbGwgc2VlIHdoYXQgZnVuY3Rp
b25hbGl0eSB0aGUgcmVzdCBvZiB0aGUgcGF0Y2hlcyBuZWVkIGFuZCBob3cgaXQNCj4gYWxsIHNo
b3VsZCBiZSBzcGxpdC9leHBvcnRlZCBwcm9wZXJseS4NCg0KSSdsbCB3YWl0IGZvciB5b3UgdG8g
ZmluaXNoIHRoaXMgYW5hbHlzaXMgYmVmb3JlIEkgc3BpbiB1cCB2NyBvZiB0aGUgc2VyaWVzLg0K
DQotVG9ueQ0K
