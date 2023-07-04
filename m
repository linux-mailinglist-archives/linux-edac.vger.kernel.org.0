Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754F07467CF
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jul 2023 05:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjGDDPA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Jul 2023 23:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGDDO6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Jul 2023 23:14:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41524130;
        Mon,  3 Jul 2023 20:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688440497; x=1719976497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9VEJyBbcunqEGAktwvxMVvd9+k/C92eWTS++wqR/1U4=;
  b=g77TdTpk88Uton7vBavKk5hJUjxD0VG0fpwf5NAx73jh39gteK8ZU7Z9
   5Ps2Ra3Ur9WS6GYeL3tgOJj14bAb++1cx9dvSuAY1jBgZRNATVmlHOptm
   2TB1RDEzpUG682b5ybjeKS6MtLmGiGliHt7EIPjVMx61jzlE4Pe/PbvQ5
   2toY5sErbb3cniT/WIiDXo0qfiaDeQk+TZjmS1AEXhBKI1MqZ4fMNyL+y
   5YJUnoBluLC2T5PrGaDnXHFKh0+f1uhrzTkHQ8waT9BfAQZ5yZmBJ+TvD
   1ToJkKqu1trHf3Gz6wi4un8ftpqi/nxLYTvNdvp7hadj+pEFhUe/MecqR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="363055470"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="363055470"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 20:14:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="788716308"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="788716308"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jul 2023 20:14:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 20:14:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 20:14:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 20:14:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Suz06s9Omb+AP3u0zKU5Ou1vxI9oStsOP1LL3mq+hGzSSJVRpTG+SK58FKtkFYNHxfcT05mTiVa3sWJVWO5K+nyxfyvdr6079jkrYcRadwdM4IS9+baIg4NOF56uv5lgexD8rz3zsUbyrIk8JsOp3uI+NLq2Iym/9Wv2TfIKluQBUhAoZTugXqXegCJmMGoeA77XDLi+HiILeJ+Q7cYNvrrXHEbTMVMbFfhUBwLBxa0+FWzLlUGT7vMYZ9INzmUSU8QSWGumzUgMx5Ni/HU08KMistN6f4EfNRubbAnlbtqhaLyjlPNw5eUubtuf8u0jQr3nD2WbCRnfUZn1Thrs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VEJyBbcunqEGAktwvxMVvd9+k/C92eWTS++wqR/1U4=;
 b=lhP4WleNusbptgRxyHAwjU6A5u5Z7Kl699jE2XTjPhzksxDbaVo2VruBjgQm0f3bEwgRpbwVNfi9lbqVioxUJ5mAo6HkuwA8aDwKQgOrCYE1b94QQTs3hdInJ5ABtpitAAAKJR8cBZ8lQ4HrwOYRElNwnOkw5UVQOAzkG/Ey0l4ry5WOvei0c6hpbNgyaAmKxNW4GZ5FcHMwMXebvehW8GHSdKuWufukL1nX0gKZtWOiHWqwFDXAYPvRPmLLIk0ZGIwxy6nb76eZdyo8EaBFRp+mzNEWTdIQKWBAg54OZh58K1LfB1yc2Bu2GTPABNLXHNuQq94+3EEqyxkYxB49ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB6905.namprd11.prod.outlook.com (2603:10b6:510:201::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 03:14:46 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 03:14:46 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Koba Ko <koba.ko@canonical.com>
CC:     Markus Elfring <Markus.Elfring@web.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "James Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] EDAC/i10nm: shift exponent is negative
Thread-Topic: [PATCH v2] EDAC/i10nm: shift exponent is negative
Thread-Index: AQHZrc6A28+shQPK+kOOa0lv+6OuYK+ojzaQgABJA4CAABd6AA==
Date:   Tue, 4 Jul 2023 03:14:45 +0000
Message-ID: <1D7C9A01-C95A-429C-AC06-94D6188BC4EC@intel.com>
References: <CAJB-X+UB+eYoYOOVH2bqnnVEJcLrxaj5A7-zyfgBM7hOf4y8zw@mail.gmail.com>
In-Reply-To: <CAJB-X+UB+eYoYOOVH2bqnnVEJcLrxaj5A7-zyfgBM7hOf4y8zw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB6905:EE_
x-ms-office365-filtering-correlation-id: 4bd0439d-2fa1-485b-0660-08db7c3cd19f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GcQSeeKJpOszebZlxB25gOk7ArZS7iUYSZl8JB16KGM2Bn7s81fBRZuaewbNglr3BdoFfTOCnf+k/BnL4OrEvl5aYN2FJQYhHpJwK+xfWvoJ4HIeA5xt449FeQxD+Fhf32W9JcQVj/H9G/fKyIfxXWP3moS16+wmMYOziNyOJ6zRx3dmH4YMY9qhhTstbE7NXeGbPrCGuUYEZj5GyUSA/Cn3nrKiKZ3hruhWWJwjI+ZPz1TyPCU1IQEujIiScZlRbon4bVxVaIzhAI43dDu1aa4pLpUvIlQvNhBXRrOiLZ1GP8XNz3Ea/An1tJtC3Je8Ug5Hd6P5gPn9iaRZY1eBakixUj0/l+h13hklDhOFq5zO3w4vIHQDgrwSjbEbgwinnPVtKrTc0g5PA4kmJyUuYMrKgU6HYVpd9T43XcGtVzBUyhQp7J6+1syZ8bRtzL/FfOkfRVS3OOLiQhl+R97BON3TO2hvgY2m51xr94sgGVMUY70LmGHJvdJ5zJ/qqMweMFP/gye3vAFH+X/1J7pTrbFxerMllUQdGIi5IlnggiR+yc/HZ9nr9GeyadDuVotpUfpk3HeFINV3ufmURnXKBXNpMWjdOcPJCilRnJKcN8BTkgyoRJkTFtMyXFqn/cNQkA12OC6Ee/I6ZMBzA9n52Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(4326008)(316002)(66556008)(186003)(64756008)(66946007)(86362001)(6916009)(91956017)(76116006)(66476007)(66446008)(26005)(6512007)(6506007)(82960400001)(122000001)(2616005)(4744005)(2906002)(6486002)(33656002)(38100700002)(71200400001)(5660300002)(478600001)(8676002)(54906003)(38070700005)(8936002)(41300700001)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1c2MFcxQnRUek5iTUtKOHBwbjFGMVNhWjlWRElBdDlwa2VVZGRNbXA5ZnAz?=
 =?utf-8?B?SG9Ma3Vzb3YySC9DdVY2NlR6bTU5b0Z2RElPNDBOWGlHTTJCWHJHMDZGRFBx?=
 =?utf-8?B?K3pCL05jSm5KVVVXTXlkdmRZY1Izbm0wSXEwVldQYUhoYVJqMVFqOGpJS05B?=
 =?utf-8?B?Yzllb0RXdUlIZUNLam5IKzlJbVJ4dUlDTDVPWGl2Yk53OUJaNWZqL1RydDdH?=
 =?utf-8?B?S2ZBNkE5Q0pCU3lmYVMxRFlHZk9LTENmbXhuL25zdDYxdkVUc1pvNlJrNFZO?=
 =?utf-8?B?emhzdjVpeDZsakJISEdiL3V6RFBsZHErVkVsOVRWY1gxRGxBWmNQL0lOa3JU?=
 =?utf-8?B?MTROc3k5RTkrTXBXQUNmUExicDE3S3E2VzJCbXk2R3R5cisvYTdZWm10STNJ?=
 =?utf-8?B?M0luM3lKSEo4ZTJxeXVBdXAweHNVVXRSTzBnVHlVZExhbUlod0hwRURBSVkr?=
 =?utf-8?B?NWR5SUZLeHhURXFoVm1KN2RqRzRhL2tvQmY2d3F3U0wxd2p6WUQ2ckdwcFZs?=
 =?utf-8?B?QXRINFpTRG1rTFFaNVdKTDk1ZEhCY2UvRUlXUGh4L1duUmdIcWhnSHptNXFs?=
 =?utf-8?B?bHpBR1RjUWVCa0swMkFUbzR2ZCtHSENhbEhiSlBTZk1KTldlbjgzUXpDRTNT?=
 =?utf-8?B?V2VraXVNYzc1N29uRjlyaFlvQ0o2dWswemNRTlR0RGhJaDFXWlQwVTFxcFBq?=
 =?utf-8?B?KzFGL1lEMlJ6ejNLQTFTQXJRNHNubURsaUcvSDFUUU5SZU5nNlFyQUhkN1dF?=
 =?utf-8?B?MW9LZVAyN2h4WWV2ckNJSFB1V2g2S2J3UEtDVmlmWjdMcHhBclhtRDR6NC81?=
 =?utf-8?B?VExpa0YvNW9VZ1orcy9jNDEvUzJLK0ZTNm02L0VIYWpOZTRKWWpuQm1uQ2Y1?=
 =?utf-8?B?aUVob1Q3bDlQQ3RIWGkvZU5BbXR3anpqQzRXVDVGbzJVdmRMWjg2cVl6aHps?=
 =?utf-8?B?NHZabDREUE9GQUpvU0crR0lHSytnRTM2T2N2RDFNSUlJbm5sWkRyV2F5RjRw?=
 =?utf-8?B?Z0V5Qk50ZDl0VHBPRUt4ZE9GR3VBdWx3WHBpSEZLT1dLanRFWWV5ZGtoRGRP?=
 =?utf-8?B?SDVwWlh2TVUzclF2VEZ0elFIRHFoSVhsb1IyVWU4R1E5WjBDWGRjWjVVcDVx?=
 =?utf-8?B?c21DZjAvUW5LOFEwS3Y3c2VZOFExV2RQRVBXRXkzRlhqNHMySXp1UEFFZEFu?=
 =?utf-8?B?TUJ6UEhBekNOOEZDbjYyMC9wbTRUVllSWXFuSklRSllTQU5UOHBJQlVOUXhI?=
 =?utf-8?B?L0pTT1d5TngwVlVVdENXMXJyQ29EbzhSdEkvWkpqaGo1Vi9ubVRES0Fkb3Z0?=
 =?utf-8?B?Z282bnNJbU9QQnlzc05IQmFJLzZCQXh0YkdNL0MzUitJNkZ5Sng2YkdJY2pU?=
 =?utf-8?B?ckVWT0NUaDlzOGxYRXdOT1RHZjdIUnk5dldOVFhvcHEydHN4NnV6Q1ZRdmxJ?=
 =?utf-8?B?K2I3dmhGeUFrb3UzbzZpaE9JVjZzL2ZyR0FrM1ZGN25BUUd0MXhNMVlLTjl6?=
 =?utf-8?B?cm94cXptVmNkcDh1N1pSRS9QczEvQ214V2s3QkRQSkpuMUxkVmI2eXgrU3Zp?=
 =?utf-8?B?aEs0aGtxWHRYbkVYTUxnNy9JQjk5RXJJb09kTUlXYUNMOU9ocEN2TTZRNm9N?=
 =?utf-8?B?bk02RjYvcnE5NUN3WDBnYWJaeHBkK0l3bTVZTGJ6eEk2emt2Wnd2dDlyVVFI?=
 =?utf-8?B?aGd1WkNBdXUrT3R0MVV3ZFMwbkE3bE9ZenFGVGsxTHk3ZlU4dDRWU0VEeFlC?=
 =?utf-8?B?eHBRcGczK2hNamdjSkxkQ21VSWx3UGdXMkZYZ1pNbGx0SUNHM0l4WGRyMHF6?=
 =?utf-8?B?bDVaUThrMzVjTGpEUGNUQkI4a2h3Mnk2UjdZcVltMHJZT1MrZytacjZJRGxP?=
 =?utf-8?B?dUFZZ01McG14UDlyQVBZUk9WdkdsL3lmQjY4VnNLdTRSVm9LdFNVN05iOFls?=
 =?utf-8?B?SjhGMXBVRDFNZTVsTmVqTlhUVVdsVUtYTURGUUpYOVNuaTVqRURldGdtT00v?=
 =?utf-8?B?anRQK3EzZXFiaS9mM0hvWmREVHBwbXczY0wySVB1YjJ4aXQwK0k2RTI3OWNW?=
 =?utf-8?B?RGpHVmoyTzZzeFVkN3V4VDlVSEJ4T0pVdnlkQjZNNkdVSVlzcnFSVjZEYSt3?=
 =?utf-8?Q?KkPgYhw6OHhKhBPlttVxRja8U?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DAA6108EEFF5D429C726302B997A05D@intel.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd0439d-2fa1-485b-0660-08db7c3cd19f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 03:14:45.9564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3UG6/B5tHk9nSqC93gaWpubn9b8XZSNsmNRYlWZ/51uyIzjZzweTX3QqXEif8U9SjU0r1ldD0YLvjeyOWzgJhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6905
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

SW50ZXJlc3RpbmcuIFRoaXMgaXNu4oCZdCBzb21lIG9kZCBzaGFwZWQgRElNTS4NCllvdSBhcmUg
anVzdCBnZXR0aW5nIGEgZmFpbGVkIHJlYWQgZnJvbSB0aGUgcmVnaXN0ZXIuDQpTbyB0cnlpbmcg
dG8gZGVjb2RlIGFsbC1vbmVzLg0KDQpJ4oCZbGwgdHJ5IHRvIGxvb2sgYXQgdGhlIGZ1bGwgbG9n
IHlvdSBsaW5rZWQgd2hlbiBJ4oCZbSANCm9uIGEgY29tcHV0ZXIgaW5zdGVhZCBvZiBhIHBob25l
Lg0KDQo+IFsgICAgNC4wMzIzMzVdIEVEQUMgREVCVUc6IHNreF9nZXRfZGltbV9hdHRyOiBiYWQg
cmFua3MgPSAzIChyYXc9MHhmZmZmZmZmZikNCj4gWyAgICA0LjAzMjMzN10gRURBQyBERUJVRzog
c2t4X2dldF9kaW1tX2F0dHI6IGJhZCByb3dzID0gNyAocmF3PTB4ZmZmZmZmZmYpDQo+IFsgICAg
NC4wMzIzMzhdIEVEQUMgREVCVUc6IHNreF9nZXRfZGltbV9hdHRyOiBiYWQgY29scyA9IDMgKHJh
dz0weGZmZmZmZmZmKQ0K
