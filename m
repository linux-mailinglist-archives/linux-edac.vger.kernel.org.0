Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09E0741692
	for <lists+linux-edac@lfdr.de>; Wed, 28 Jun 2023 18:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjF1QkH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 28 Jun 2023 12:40:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:5515 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231453AbjF1Qjw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 28 Jun 2023 12:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687970392; x=1719506392;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=NcSWNfnnIr+dbIr2LERZwLSl2pLxz+OMtPnbznhJwEg=;
  b=V+RLrmVxWvYynDQ/NmP9mebUJj6i720PTQdR890YlPVtJhh5TgVJIKaB
   T32rWCuYdQLrjIHxfWKjvQCvTfxeywD0PkRrthgpBzbQJSr2hPLG5M/zI
   z2GEdkUXY0lq4FazKI9lYmdtHEtYCkdLyCRk5qA6Xd4PEDIOvle6b0bO7
   4g0CJY5PQOeEeIw5T0Y3ElFV28xuNADSWyu++Sj7FsGJ8f1ZRQOwYrMEs
   awVAh1XZN29sN6q1J0hS2oswJ0WkSmjajZ9lnr31xTks96lTiiv6J8+6J
   Pk4jVMow1NWkMi1OoHNhlLpe/sILZek6vz4CFrNmqeb5HFywKqUXC3W7a
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="346663329"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="346663329"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 09:39:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="1047483142"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="1047483142"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2023 09:39:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 09:39:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 28 Jun 2023 09:39:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 28 Jun 2023 09:39:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1qgSSVAPQLbl8ukm82H0mtj8di5sBN79jetAM4/upgVo7SLGum/+cEHHtXnxiThvpMAP0ofLInnWTeQP8cfbo/nSu5umR86Zb2hz5kIXpOMZkkYaDBND2QZb1QGHMWUWwAY3Sm18qH8Ls+sos3bSRJKpgY83LZJTfylNLNYf0jCUiMGRA9dmtWu+Rf3SGn52s9CuOvohSaJ2yptFVVg4CPy5qmYQNxbsNuhaAS37qqDR4sdL3I3PztNmFdav0Qgp95JTHHWuQmh1OxOowZh/PEA4d0ZlzH6jnOBIMfCU0RIuWXh8iHok3IdvzQ14XfPNKaxafOL8Ik3XLdbjQH1fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKINcCbuSz0ySZST86irRZIJqmaY1pFm016p53se7H0=;
 b=BYR/lOr6aMDq9NQ9N7wfP9WuNUG1fVfk0RSbIPSeVWlj2JD/q14RjTwoZ2Wl0qD5xUyeNdELkUtoATHFSnp3zZs8H0blKYb1e5/hAITWi6do6/BGzC5+zl8Wa1LMoGKv4csdPyJt4YEIfue5/GsTX0qqTS/yTaIm2sQEco5EHd2zOB7lagxpgfuXhR1xHa+y4xI4Bs4Q4xCvAF3uEXmOnthDtKNiaNBwRuE809DjE8qimoO5mxszWiQd8wNqIqBATTtRNrIVLLfEe5FDoWlj4i44MwdXitdXaN5OqIKMt8qX1bg0L9H90ScQnlFMQxYwgK4Xzo/agT8C/hL8G2wLIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB6655.namprd11.prod.outlook.com (2603:10b6:806:26d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 16:39:46 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 16:39:46 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Koba Ko <koba.ko@canonical.com>, Borislav Petkov <bp@alien8.de>,
        "James Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/i10nm: shift exponent is negative
Thread-Topic: [PATCH] EDAC/i10nm: shift exponent is negative
Thread-Index: AQHZqZ42gpR/+sqH6EKfNSuXrGx/Qa+gaXxA
Date:   Wed, 28 Jun 2023 16:39:46 +0000
Message-ID: <SJ1PR11MB608340E81A15F20EBAD75F08FC24A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230628085253.1013799-1-koba.ko@canonical.com>
In-Reply-To: <20230628085253.1013799-1-koba.ko@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB6655:EE_
x-ms-office365-filtering-correlation-id: 154c76e0-5bff-4804-d43d-08db77f64885
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nxsCOeb1FqYaFBYCHUTvXAcLxCzBG05tGUByXknwBp9jKKWtklBKvtLUu7SKDcK0zPVWYSWhrz8VGHtxfHVr025Gz2JQijo5t6l94fLJEXA/HKq3RZl7jIdYor6mhEflhxjcBIvdkJjMzA8EIHURGUP8msf6fE5cBjjKisdNkXI99LM3RuyXO5BTRZ46+dpiNWO+N8D/IVXo9B98V+Wvy29MyFB9/Pfb0DASZpQvTjxbXp2eNNDj0dnknnjY0k9d0v3CDj5XW9oTG4dhVrG31JQ11so6dIZ0DdNgEi22GBGIZsprNR4m4dCFl8mS3t92M+An0RzeoxoXb/jo8Yfwc+yQxNS+hZdID7Lry3skxnUE5MzkuTjUsqqwAUejaYFK0/78d5pa+N6n6WL1t0s7XpfcOFijAKLzYi//XscncRJfBMcfCf5o0wnNZvA217F1A2zXaai+WNlrE48qBytjsxMGRIvckAoVcYOmyNhPN1V0QwUzKclTBhJDz5kJ30GML4mGa33UyWSM/ckPQVx1eRjjttiysC44fEVi2QmO5tMaSHXfhN/kGORHWFPxF79vOXHZeWO92HO6es1pGxeSud7oUhP6FgrSG/7h8tDzaqsTU1sMuRwzG7PQ+9j46i2L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(52536014)(478600001)(110136005)(2906002)(7696005)(26005)(83380400001)(9686003)(186003)(6506007)(71200400001)(4744005)(86362001)(41300700001)(33656002)(38100700002)(5660300002)(66946007)(122000001)(66556008)(316002)(82960400001)(55016003)(76116006)(8936002)(66476007)(64756008)(66446008)(8676002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6MYkNN92uKx2lVX+UcCr+27C7KZiBQFVhsYiPdAKVxRwJU0owoq/8P/X2GJq?=
 =?us-ascii?Q?PdNaWlaJRuUeStKlmgrllEcqbqjOsraBMl5zF/qSfMbYx26pr91KouW4MahC?=
 =?us-ascii?Q?ukywsyxnOwrsXoqZ9DlHxqzc7oQJhDzCAR08oNHyCP1YDiQPReHfgzwJYiS4?=
 =?us-ascii?Q?tLczxKAMwKWZ43Gopt4i+oFqFSAX+6IrD+eyo4BgSox1Np+Fm6XaJEBsGCWe?=
 =?us-ascii?Q?AymdAn3Fe5JHryeLU4eZYZXaiT01cRFKZ3BYkp1BXkpTOoiuCii8KDE1QKwH?=
 =?us-ascii?Q?ZzeR1BSiR6NAohnynOcf9HO8ZZ6EI3LMStnOm5ctGIsjq6e9zKbDNH77tp7o?=
 =?us-ascii?Q?3xdWyg3ItXzmtxWVTDpbwfwJwY1Vc+2l+cyfrashiVUOJ8twPj6ZPsGUneem?=
 =?us-ascii?Q?7mnzwzlxLNnfZhMTVmSP1JPr1ja31JAXdMVkEQrvi44J29ZdFr6nhwibTZ1Q?=
 =?us-ascii?Q?zOy1HBY1leyI3UO4pTT0LSSP1KfyMXjEULc9QeLiBX2uxuv4bWf3ouTIkH0J?=
 =?us-ascii?Q?kmcYn1qTbYDNb6ZccvinpxoyHh1ED5c0K93TZB44sU5yhUwpf3SEQb50siyW?=
 =?us-ascii?Q?+WG3pSKZMSGQV0i/TLiSxB7cY2U60mtbYPyVSgUefwwhlGdbDSgllrX3SwE2?=
 =?us-ascii?Q?3sDoniMvVeyjS6R1lo0MPxmbwMoWm73CUUz/6PiNFboNDVWOxcCJ0QTQMgFe?=
 =?us-ascii?Q?ilETevo6aL/4gjNOWKXnWiG8fZZdH/TCd9Pr+PCpeksUF3urnWBXKLE/E/gV?=
 =?us-ascii?Q?oddfae76umnD4E9VXqG44lrC9O1HaMJzSBiVzSZxDM4iSrYQrwgyuF3AMS11?=
 =?us-ascii?Q?4geogoQ4M+bDCOHrM8UX6TFLrawe16wP8f2FUAelW6U1RwVg6TkbmH/cvtDT?=
 =?us-ascii?Q?KbQEpm2bf8N9SKXKdp2OFOgEav2yqhuqRy1Iuq8Y3rTXFenO73f+/Ch2dgjO?=
 =?us-ascii?Q?Z+Eu5fIHM0yVrDd2z3748ZY6OfSQV/f9eNWmfdV8b4a07BY5ccUF2YBmXKpO?=
 =?us-ascii?Q?n/C5I3OxY6rJeiju8H4b8OkyBFY3+IJWVCBKZ++XR297HY2ZMVyzaDO6fWUu?=
 =?us-ascii?Q?h9NFKKo1IU5n8OmGQB6ZmKe2Y3IUkupHuvaZs++jhNyB9stldDvT16tmQQyN?=
 =?us-ascii?Q?urCLz43pxIjv1Dhavy/EtyedZkwHkL3FY9fygYRC12OJ8xfOr75rKG/4blGZ?=
 =?us-ascii?Q?WSf0RR2KgXXYfDTe5YrNfFT4wraJUpmScBhyMDAzdGCZw6pvGVpAIOjY/9Om?=
 =?us-ascii?Q?AZDaaGbtU82gpli4X258zXF96thV5JybWJ1fGoTtjRaMUCtQfqcrbOnId7WI?=
 =?us-ascii?Q?XK03KcahNJajDURxvyHZzSfu41WYG8W5Ye/rR81YLUk9ty52axFhKC1INhCc?=
 =?us-ascii?Q?QUca8UYpZY9ATF5dtk4MttQ3B7JS/iEI/gHs1UXkctSOSSkyiTqJ/+aUxz8Q?=
 =?us-ascii?Q?BQ4CDK1b2hKgqm+IHtbO3/6hy/d1/Hbi7sRnWeeZNIF3ZggnsUwQHJH4cU0G?=
 =?us-ascii?Q?Lf1PcDR62gPFBdI2ePbLERqTpRQSE2PA6S8czWsETIr5jRGBWPPHAkqDs3RP?=
 =?us-ascii?Q?hXNBB7DBKKgZ2L6/kGA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154c76e0-5bff-4804-d43d-08db77f64885
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 16:39:46.5259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7aKYUhyAEeAeV+rMocGZjL8zuN0H/y+WyzP71RlXCuk7JpkBE7oR3KNXuECRZ3I5+4k90tSuDdIgEGUjuNIxPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6655
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

>       ranks =3D numrank(mtr);
>       rows =3D numrow(mtr);
>       cols =3D imc->hbm_mc ? 6 : numcol(mtr);
> +     if (ranks =3D=3D -EINVAL || rows =3D=3D -EINVAL || cols =3D=3D -EIN=
VAL)
> +             return 0;

This seems to be just hiding the real problem that a DIMM was found
with some number of ranks, rows, or columns that the EDAC driver
didn't expect to see. Your fix makes the driver skip over this DIMM.

Can you build your kernel with CONFIG_EDAC_DEBUG=3Dy and see
what messages you get from this code:

static int skx_get_dimm_attr(u32 reg, int lobit, int hibit, int add,
                             int minval, int maxval, const char *name)
{
        u32 val =3D GET_BITFIELD(reg, lobit, hibit);

        if (val < minval || val > maxval) {
                edac_dbg(2, "bad %s =3D %d (raw=3D0x%x)\n", name, val, reg)=
;
                return -EINVAL;
        }

-Tony


