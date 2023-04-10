Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8705D6DC974
	for <lists+linux-edac@lfdr.de>; Mon, 10 Apr 2023 18:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjDJQlX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 Apr 2023 12:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjDJQlV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 10 Apr 2023 12:41:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8D519A8;
        Mon, 10 Apr 2023 09:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681144880; x=1712680880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n4pPLaOxBhcZr/vsaWu5y0RZpzFPOAaWQXQTJUhrVeo=;
  b=MujOPw/mzQP9mw3UlV+BkvctGOPGyf7GB0NHZNSh7chvd8QDJzjtk+XV
   wnf2VcLdmM+VefXBjxOmWjzwDiZDNW7EUhfgaFH0/9lbVJE6q62FJrmLQ
   AeT3WWCSIC4Obokk9VZoYFp8RcgbudDT6+UN4hyFSWMeXPW7XU7d/cQHp
   CSpnuJdMvvHIr+BD+et0EYZK55mq5Rhikeqji99gGBeJoHDdkVyyIGDE4
   clGUUGVTLF3/TPW75VosY8tSWsOI505W9gjlJmQ+ICBhA8csQdN1XiCZX
   zgvbzsJ2/io0RAW/ttrTbePeBCgMSmIgR0jB9raUfNma+V6r9AFIxVdF1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="323031168"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="323031168"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 09:41:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="832022928"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="832022928"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2023 09:41:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Apr 2023 09:41:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 10 Apr 2023 09:41:17 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 10 Apr 2023 09:41:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgAL7M9bZKooAXpuH82vQUlesnf/TYaz+568F0kVLebFd5oBU4mLHtnVwL/SKPdKdSCuW92MOTWMhh3iOM/RHpbo4WgrrBq+D1m//uJnIlMvEJn1yRoGzev65wpjUI4Q6qCjubjWJTSf3Vcicz0SvAbsXrjhH5rVJH7cn9YmSxarFhmbV0Qhw7onmO3SmrP8+gC4JGudCS4KRwLDOSk+834rE9x9N8yaNKlM+3CD1UWS+A32VxT6a095y/Li1DVP+mI3z0taKn8W+IWbkCGAj/OtbdIILMJJIWRJvu6+dxGbt5tQBo5VImkdX0JD/tGwJhPnGqjtrzvKr49OngnatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4pPLaOxBhcZr/vsaWu5y0RZpzFPOAaWQXQTJUhrVeo=;
 b=OqmfagVNq5SkiG5Xgi/CkdN2LvC7xUAPFnnsPzHkLvf99FGVlR0BWJj/I8L5s9Nsnq7guXbOyse6X7Ma9wpcW9pSCF6TdhWbENvZ4o+NJTh14RcIw5ogCV4ycibod9yWEnbzGLmQXNVQE2SpheqD8aIFeierNnu9OSb0jaBqk0OXL8N4gSEq3Adimgidk2AyKzoxnScurrzqk7V6JV0mzykALAfPG3lFqzMP2AGjLUQIuw2oQWGPQsOZZKZxiyxcc7L4U+4maVunxHcAUf30pp8k2JNTmylPJzAQP2Dk/gEqzpvx7p7rSFPmkgcujzgzEmN0TCAQG1XtkdXZZLyAgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB7301.namprd11.prod.outlook.com (2603:10b6:8:10a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 16:41:13 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f801:5faa:7a43:309e]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f801:5faa:7a43:309e%4]) with mapi id 15.20.6277.031; Mon, 10 Apr 2023
 16:41:13 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC:     Borislav Petkov <bp@alien8.de>, Aristeu Rozanski <aris@redhat.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Zhang, Rex" <rex.zhang@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] EDAC/i10nm: Add Intel Sierra Forest server support
Thread-Topic: [PATCH 1/1] EDAC/i10nm: Add Intel Sierra Forest server support
Thread-Index: AQHZa66bCoz/AoqT6kWgU5GqufabHK8kvsWA
Date:   Mon, 10 Apr 2023 16:41:12 +0000
Message-ID: <SJ1PR11MB60832B2B21119F1E75DC23BEFC959@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230410131531.11914-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20230410131531.11914-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB7301:EE_
x-ms-office365-filtering-correlation-id: 075ae102-6efa-4893-4d1d-08db39e26569
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qeu6DNRpOAIPKYcrLIpyHJhdxtxP2E2zcx3Cha88nAil/Vtf9p9qkgtpxSuZj6mAZ89S+qx2PGLD2ocMsflnbIGxwPfI2d80t9p2GHW17grEQtJ2VVayghab5+blFEjSCHf4FN+4iBFXH2CpOfmFW2Y01UNGT3qbR6Gk21JI/khswCreYxZorJUzbDUq2vCM2FEnPC0Aq9Gh2fk3DhsiirCuRNSL+I3Wcj1h536RTaS7ujDmrn0tcqVavnQUuC9+yGaez1pdsqWTV5LmyQJRzV6z9a/ekf4iMoPq+RVFJUMxMNaQp9lyX+fdXZSImsF9kNsm/eOv6nh3aYjKAya9sh8mHRYgQ9cuAHkzJwP92RQEXhZLBucQXV9Q1uAa5S2y+Nc3O/SDOAqcb0sGTu245pdjSB1kpBLkzW0rEnxC29AeBZSpoFXrhfCFSQLX+3KE582lLG/shxph7Sum6EzXsV3Fofru/i9We78PKvjyS2sO4wv1rOPsD7CrZigRW7Eq+mM+YQm1weLZK94EkmwkhbEjhOq3P0mm4q5IB4eKREDSqIRJVUpTtZMpuTRosmNckXQzexVLOB7enDXmkbsqrO1nbxTeq04K34s8GgHIm9bJ2tioRYiKLElNvrDzW5NO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(478600001)(7696005)(71200400001)(316002)(54906003)(6636002)(6506007)(9686003)(26005)(186003)(2906002)(66476007)(76116006)(66946007)(41300700001)(8936002)(64756008)(6862004)(66446008)(4326008)(8676002)(66556008)(52536014)(5660300002)(82960400001)(38100700002)(122000001)(558084003)(86362001)(55016003)(33656002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gQoLsWpkLF56R7I0M6/ULo7kGSs60yBKbaqzm1sI1uJbf40ZeTAQ+3W1JSoK?=
 =?us-ascii?Q?B20LyLdWr8tMmX8/6CcpxJ3aCTHQuZ12tIoCEfaMjV6SEsCKmbPSTd+AMwD3?=
 =?us-ascii?Q?SvewNLTv4BaWq9vrLmWzZME8jHFtIMHzv6biSl4T/oYUlGbrsuQGS5+HwdfG?=
 =?us-ascii?Q?3Y6CUV1IBtGx0+JU7stlNpBGZfkoPgjXOyWotFn5+xXILiQid14a38vlegxR?=
 =?us-ascii?Q?z4MK7srWGB2iKj8a5VABolSbTlRyBnzuNyO0BHp8rSc3p+ehh5h6unhffj1u?=
 =?us-ascii?Q?ISxLjhTVUVpbaRPcwXAbj2gJTbt43GLaFWO2KuYmlUB3yfwObXreMkGqx7AM?=
 =?us-ascii?Q?TVg2aCjbkeJ3GqDeK1ceh+1h13qvqc6jOEnKJ1iJzVjqIaW+1svUPessE5Po?=
 =?us-ascii?Q?kvLbvJwGQaFKimUVIo85lcxLuwoyMCCKTNW5/0CyUol+gZn2d8Dyvz67yOom?=
 =?us-ascii?Q?D4bLavHCzDjv08+JeC5S9XTMQmOjgbzT+nNK6LD8zfl6E9K0JILyvsH9VjGM?=
 =?us-ascii?Q?AKwhsPU6ouRkJS2SK+3kQhsQTNg/JothhXo3iO2zGHJBU9z/abXiKbuKSbKf?=
 =?us-ascii?Q?bbXsoWkOwgY/2HvYBfX+Z4I4Jv7SUTfgh0tEVxPFrYtBaZXb2ONG7KEYC2Dd?=
 =?us-ascii?Q?Ejr3i2stQfYPZFIiTu8f/j1KoMjChSn6/BcvzxfWBaEVQ3hJO2lq6kN9AHBq?=
 =?us-ascii?Q?zbrXJa79rhYRn9YyEKLe+5QolOsKuMYDcpnemPRXvlY9cdAwI1RQYCF1O2Pj?=
 =?us-ascii?Q?z3HwI5LWcZznoRf4g80UxJ9AoYFvwWY1h0g/Ozn8UQNNRKJ4pADpbzVtUhHv?=
 =?us-ascii?Q?tyUohW6+LhszOYfHLYiXbpTEHHq+48zRiKzeSdGocWDegtcE6/oRPRq6jac5?=
 =?us-ascii?Q?3WWcw0TeFRJ4zFqhrzs1iIW1s1WHeci/Q0nPyHpbBrghhYyjzn7H8pl69DH4?=
 =?us-ascii?Q?gUKiIUoWlIZ0OkaDEgK50+n/tZH1NoZ9Qb+Xa72zRkbC/Kbdq+UWf3atXKf2?=
 =?us-ascii?Q?u1DvHArtIuVP/V9h7Wtwqm+NMJLcSKZI27ys7ZD5gMVuOM8w+QZi+6L6PXyD?=
 =?us-ascii?Q?FYD/UxvGOvIJeMuj02/CHYCl5makHU+/fyPXTbw7uXO3k5rrgnx58kCrstHc?=
 =?us-ascii?Q?uZ4e5GNT6OSj/FPT8G3rAZrY9Jrk95RO0b18MALUvRT4T83tEv8xSaUapJJm?=
 =?us-ascii?Q?NCJveHhVtAgqryixsRmlY2bWwTPW1WcSYD3Vs8BVnhTl51CS+txtEb3EIWn1?=
 =?us-ascii?Q?20K13sPAZ2JJujoZiwpXP0oxHqkyH3JffoJE2iWrvnCznqa2I8TVnHV7Q1K4?=
 =?us-ascii?Q?r04kZa6KH2g+7Ky+IGSzjQrbJaVNY2F1aaNJhnqOYJv1AJfPMu5hbahrLVOe?=
 =?us-ascii?Q?If8al3An31vURyjWjCOINNly/aMDiInd54qqHnbP/mL6YcxXZ4PodTlAvm4V?=
 =?us-ascii?Q?HScizr0EMujX2cZS+fhNAZQxWOClTd6HMzioFKjvctJSRB6EL1WNeXBrWNvi?=
 =?us-ascii?Q?sAQWGR3+GpyzaRVQpcH3eVZJwq2QC+L3V8vV0hNREJy3hiNK5q2VnCdjoB0X?=
 =?us-ascii?Q?9dnUFumyvDpc2GnXpes=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075ae102-6efa-4893-4d1d-08db39e26569
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 16:41:12.9240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kHpyZAjMX/iiuapk4kNAynGOK7fQGyaBsdsKa8UFPXTeyBxkJcdMs8oeNjgyHsbf4LaCXm63hGPgqaNxLMBNmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7301
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> The Sierra Forest CPU model uses similar memory controller registers as
> Granite Rapids server. Add Sierra Forest CPU model ID for EDAC support.

Applied to edac-drivers branch of ras tree and merged into edac-for-next.. =
Thanks.

-Tony
