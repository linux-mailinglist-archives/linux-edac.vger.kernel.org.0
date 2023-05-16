Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4903E7054BE
	for <lists+linux-edac@lfdr.de>; Tue, 16 May 2023 19:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjEPRN1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 May 2023 13:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEPRN0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 May 2023 13:13:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A448F7D8B;
        Tue, 16 May 2023 10:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684257205; x=1715793205;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hpQv+rAnynqmKKgoNlbYcn+NgupC8Go32Ot2OqVKmbs=;
  b=OvRTcHkQxRh9d+5O2ZjnRAAmGBJqtf3b6yMjKXINdEjuLd4qReBPJiyR
   8QEqarJkk+IwJW/++7tKeMg2DpJaT7OlswUEggV6YVY2HXw84PYxxTkmh
   80FcDigZYJMHwnpeXEGfniwnCchjsY5PsLWi9e+xi9Yw5yiTyVX5m9s+6
   Xa1kRXqnC1TorxFYi+dgez0XN5KTJdbQECj8qTy67GLMGfK4cJQOzvR3J
   lo05VPOTSA39n8Ti3BrSPcGlkg1yCqBqKf9rvkQKsiLIq1Nmlgq1DZDW9
   gaVdKDdQv5K0dPbevZuEwZCbDStNzcjys60QhEGIMcqu0N9WNrye7E3Uy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="331156662"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="331156662"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 10:12:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="771137769"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="771137769"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 16 May 2023 10:12:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 10:12:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 10:12:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 10:12:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0sXr9leNT9Ir+pvdQ/6QLVqIzvbhIlpZjkY7XYE7Y7gOwjXu5vcP222B4OAzsu9w13tva89m9o5iFwzGm2Tb2Bq8034o5c+uhUyManr9IS6vcdORwIL2saO4Xyvd0r/RfeCRSpARa4cE2Om4eDYWKu1kUJMu8kj0lBa8iqQALkgKw4I8Y0FSM3Amb8LB/S4upO/47GRcE6DV5X8pYJMoP6oJdjRHiYb7SV75MPzH8HK/BaIVVyv1TlU+HOZAGG05Noul6sxTXCXsiVkPVM31XjN7lHj+8Gl4kGWPPX0egxNoIzF2Hi2+tb2U1y/A4npISrPg0mubH3cdh18f7u6iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tT992Is9c14ifR3RTLTNOfPpH5JULq6C6jc3p+OLe/c=;
 b=enNnd3zYxuzCQpeessovGfmEiA8xuJcsNctXTd1Ptz+sX4azHHZ5oMutZ7QgMLUu1Fd/THO3lzi981JBz68K85xfdN5+LCxhJbWyshmTjl5JeOhJiVuWH3SvjtcE6fhwCSYEbW3M0IGmqUszwD68O8+mZHlS+6xYy8kKDFG1nHv4TPOqJLKQCepewZIRN4gkTY3B+vsKUZjGk9XD5PfWXcAV3TBEdz866B0DC4UrmOURnyVV2kMC/BN0l8YBuL9/VH7rs7FTKGJHQwUUIbsqHlb+1jM0drjIPNVWq9shULEHZLl3Zvb/P0dUZP+LcJ5qae5a4MK9MpTKkS5NtvHioA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB7724.namprd11.prod.outlook.com (2603:10b6:610:123::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 17:12:29 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6387.029; Tue, 16 May 2023
 17:12:29 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
CC:     "kao, acelan" <acelan.kao@canonical.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/Intel: Fix shift-out-of-bounds when DIMM/NVDIMM is
 absent
Thread-Topic: [PATCH] EDAC/Intel: Fix shift-out-of-bounds when DIMM/NVDIMM is
 absent
Thread-Index: AQHZh6cRh/4012gn7Eu/jQSS3p8URq9c224AgABHUVA=
Date:   Tue, 16 May 2023 17:12:29 +0000
Message-ID: <SJ1PR11MB608384487F94EC485C91F47CFC799@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230516033133.340936-1-kai.heng.feng@canonical.com>
 <IA1PR11MB61718EFB6DB1BF95CB1CEA5089799@IA1PR11MB6171.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB61718EFB6DB1BF95CB1CEA5089799@IA1PR11MB6171.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB7724:EE_
x-ms-office365-filtering-correlation-id: 50f1b516-e685-45c1-7d4c-08db5630baf2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ItznSLhYP5sL2u2E5L2jruvFnF1hv7S+6pn+XvYtJs0diuZI5fx+kh6RzbL/6DrHTgU0u68mroLm0kjvkjZGFKhCPTO8/0K0hYWZYEZ9f3TlmAgbjD4DR3AsK9RI5KEd2+wWVQHrOH0ZmJ2I6CTm97j0SqY1mLym13xpcuyr8uTMAK+z9kRC+kiEk7QTtS5zZBpOyEw8Qj1PdGtHbIpmwPYnxNlnVZ4IXfE5EWSkwFW4HPYtWCyXgvMmTz1XiXFCd2ZW37rtn9ixGSD3Zdq2CV9mRFFFT//nxqA8PEOlZ35SYSQMRrQTS+43Hvitw+qrztUQy0UdCchVXuMHezy2xkSeheysPOM9ogv3+/DRmkLbzrVrnBzpjeWN7uPBWzPcFVwh5Z+Y+ALYCwAEXdvizEBczA+qrNd6su+r1khHlU5g+l7O2EuR4Tn07EeiMdHjjtlUgV4SVn1xQ0KaBCCewxMcj67kFFoRZE4XD+GLJYtOO8BVKjBcYxamq2ZKn+XvPEmyO+hQXHi+lCC+cxKOGaJIRxK41S/hBDVwGTiUPAlD2cRju2xwtO+ZJHgWcRlOb4MHotdmCzjWYdcOxs0EhW7Z5aHFmc4tSU73A5E75c6zFyCmggs74iay2Bmb/EI1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199021)(66446008)(66476007)(54906003)(66556008)(4326008)(66946007)(478600001)(64756008)(110136005)(76116006)(316002)(71200400001)(7696005)(2906002)(8936002)(55016003)(8676002)(33656002)(52536014)(5660300002)(82960400001)(4744005)(26005)(41300700001)(122000001)(86362001)(38070700005)(38100700002)(83380400001)(186003)(6506007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YCy4iMh2zuA8tBPqZBqD3Ei5E3z8OK7WDyZ1vVWZx6k24BSmi19YWVh4NvUL?=
 =?us-ascii?Q?oacrylIP/cdD90bH9vX9H+G20ELLQxrJYLz3GBAIfPfk7pfjxNHqWS+d6vC8?=
 =?us-ascii?Q?J/qQ+Y8VKHKYuHTDZ63vjn0ik9eYS3u2hs9kTHICvBdcKKSgCvixNmhBALWl?=
 =?us-ascii?Q?IVi+ieWsRRfB8bcsrMqAmvvmKvkVSDyCklf8SHkmf+nDfEZK8vCwecX5lheo?=
 =?us-ascii?Q?jXVpsvQ8UG4fCBFPlgiV/FyMMSo8RQB95bz+TOOwQa5PRY9i+E5OdXacghRG?=
 =?us-ascii?Q?/ge2Gilop08ZY8xHOU0wf+Hngn7x3Gs4j++7Kuq5/leg8q6dku0SuS1sXCN4?=
 =?us-ascii?Q?ppSNXBbRd0xO0Uy/YxltT3jr/xjfwT3bbmF98xOzK1WMdGfA0khM5FfOrGEz?=
 =?us-ascii?Q?aExGLgoerjvCNXPydiFB2iQtYWYGDMldYVvJl8ThWwpo2ook0IHNZG7Nce+T?=
 =?us-ascii?Q?Ar9mWivTkcN1Riv2lqvQcKoCN1KsJ5R/sYg/gPVIm0P6PxBUZasuG7PngcEo?=
 =?us-ascii?Q?nK8YbD0bimyI4gjuZXYUlTgkW47h0S2wvMgW6bLhr58CBbU8ZC1iwVGgIqMZ?=
 =?us-ascii?Q?c1JWCMbtHLcPb8u0Bh/pd+EMFXiPC9AA8dQ8arVb+z0B4zk/IvoIHXzzlZgN?=
 =?us-ascii?Q?AIPXSYsQ4zyO8bfIgT9Zzjq+6euatirdv+CAfwV98xYPn1D0dtS67RsaSiOa?=
 =?us-ascii?Q?4reDK0rVB4i/InF/zZPvI0LMSQb69nSSpn8i6Edix7XHSGKJTu6HcJifYVTQ?=
 =?us-ascii?Q?q7x8bGHF14ZPYVzopjghcZZIz2jelmRltHcUlNE5A9GSAfy9VglYGvvpUNqy?=
 =?us-ascii?Q?ZL0aNH43myqnJhLSOnPl4ukj4GYG6NZ7D6+bagy2ny04BvqNl6W2c39PlyHv?=
 =?us-ascii?Q?WwXisW5B8sdEPaIAK2FxnqpBYHleAZOYXP32x32suT3VMyHcUzMcrRfqHH+O?=
 =?us-ascii?Q?ytIdpyV8g1C4wXYwEgy4PbLoEbdv6mcPiw7ZgEow+8thQRXq5ZjfMUR/mGy8?=
 =?us-ascii?Q?ycUhveGo8frAEhhh/172V55Fzt8at1M2aoplM+3tpeKvtje7IUpyCfx/gSuU?=
 =?us-ascii?Q?wOsPdZbrAxurxl19hOTPxpNDiU3YsL3u4KwHNO33Cd8hIRb90+DccamImAXN?=
 =?us-ascii?Q?1OxE9GCSgEfh8AuuIhooPn8G4Nt4CTXNtzE8wUYftCZc6c16i47EIMrLHFM6?=
 =?us-ascii?Q?gKR7rA3qISNGNWjJL/Jki+NOBo9D1M4SL/dLL7vw8nKdoBbSslVPezqU3AoB?=
 =?us-ascii?Q?EmzZMeswLT3EbPPDivhEKK+FvJfcdY7B1rrp3uQ6egvonRbibXfgNqA2J+1T?=
 =?us-ascii?Q?7bNBYOKS6AoMAU7m31t/Pt2ZhVjxuwjh0ZyYCT0FJxPPayudpAkr+Ty4Ucm0?=
 =?us-ascii?Q?ms7gYiu7/ZJ6STjB1jezY2QJ2BWZvkJCJ5fYWa2rtrKq9Gpu17xTqjQsMO+H?=
 =?us-ascii?Q?nFwbOHwIu7opySPsnrdb6fv2bPZI2iPPCYvAIxALnJzFfhzkeJi5ygSQD8d2?=
 =?us-ascii?Q?Ffi6nid7vPqyq1T7F0YYMm8gSKSelLdjiQEiDhhyTQ3woyFXjz4Nze//XZ3B?=
 =?us-ascii?Q?9j/27JZd3aeud3GKi1w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f1b516-e685-45c1-7d4c-08db5630baf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 17:12:29.7675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dvC7cRSHfBaGeeoXyybrCkVNkL8NvmAt8sP5K2mXB5xo88T8NiPh8JaCYtDe3FRLP1mJHqjDKapt6M7Ub4VWjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7724
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

>> [   13.875282] Hardware name: HP HP Z4 G5 Workstation Desktop PC/8962,
> > BIOS U61 Ver. 01.01.15 04/19/2023


>> When a DIMM slot is empty, the read value of mtr can be 0xffffffff, ther=
efore

> Looked like a buggy BIOS/hw that didn't set the mtr register.
>
> 1. Did you print the mtr register whose value was 0xffffffff?
> 2. Can you take a dmesg log with kernel "CONFIG_EDAC_DEBUG=3Dy" enabled?
> 3. What was the CPU? Please take the output of "lscpu".=20
> 4. Did you verify your patch that the issue was fixed on your systems?

I wonder if BIOS is "hiding" some devices from the OS? The 0xffffffff retur=
n is
the standard PCI response for reading a non-existent register. But that doe=
sn't
quite make sense with having a "dimm present" bit in the MTR register. If
the register only exists if the DIMM is present, then there is no need for
a "dimm present" bit.

Some "lspci" output may also be useful.

-Tony
