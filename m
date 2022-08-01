Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3A8586E2B
	for <lists+linux-edac@lfdr.de>; Mon,  1 Aug 2022 17:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiHAP6k (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 1 Aug 2022 11:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiHAP6i (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 1 Aug 2022 11:58:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8656033416;
        Mon,  1 Aug 2022 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659369517; x=1690905517;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=iX1p+SS440486zWuVK3lN1cOPU2MpOeMLlcuiF2RSlY=;
  b=CE0kHfXGlGMFL2DoXvVFT3h1p7dmqk9Fd2fj68Y4W5krZiI91aUB4Vuy
   4g+NuuhCtv9kYr7lzqCdJdsu5SAXemC1dxRkrsz6JZnY1vFHXDLtbJHw5
   j85AtZukHYOhWKAl8/rhfxFjoVkXxkJUUf3hMyK4NVzJbe1H5iZ8lM9WL
   CbHkOvZ5zmFcl2VUOTkYRD8elR9+jjM/meZ+pJz0+RgmI/ocFwnDgFLu6
   Q5sGstRhqqrxbCYCTNLVfZvPfvNTA1yPBLv5fwWtcWExqBHD/wCK7QZWH
   L5DQm9K8JUhtEd18vqhPhsjwen7IO0wXuKNxAlixuyFh/X6VcMPWhPQ3l
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="315007697"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="315007697"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 08:58:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="929605523"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 01 Aug 2022 08:58:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 08:58:36 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 08:58:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 08:58:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 1 Aug 2022 08:58:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYJzBN7fpnXoAfY+SkVox4AKnpM8QMUF2BnJC05Y6FCE/XMVRFcMDH47SvqviO7yk7ZndPxk8IBRzyyegNZSvzVclMn8hgnJYqUjBBsm0TwDzdz3vRmqhDzWEmNsZ6mPu3+P6e4U3cxvXwi9BlBb/DBjHhOFxXmEobWl0hRHhmSJYSHvhqZsWwfbQmCHhzm6aXBP8Jz2OscCsVO0JZ03sqa+JxKclrqpm7Hy2NKDpCL0MhPHThtaVnvt1qDYipLxYcDuxHi24sjdwZ390FbZ70jto85ngpvbi3/kmI2IGaYiXpEXnPVomXEKAgK4eaaKNtGX3Ha0MRDZ/IsTRWtpfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keAk/ROJZbC/wLicCaf4MycSOR49UGjNkhZwHW7VlQc=;
 b=MmpZDdyf5GTljHdRRzPs7sl0YtD4L0XNyTTN8+xwHLDnursOv79LlO9mBoMyM5hbbjpzAuKV3BCE6Lt3EbBBKYB26KlFPEDCI6YLzGfMeyyh7nOyNul54ZQn6naGHeug0lIfq/4e2MOpokc6hwoHhDHcysT/btJe2Lw9UtloWI8ybmxyjEod5J3bxRIZ3DK1wH+wG+Lfl8CbLDtAy/D1gPUOllrSHU3xqA+I1mpCxirvg1YIDInh+e2ybcmfD3O5xN81QfQ/P90Z8CHs9a3fhGWKVNvMLBBFSRcc3TyluGtoAZHdDdH3J++ZnPcPqxPkf2kG6ihxI3H2vPout1V1yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB4940.namprd11.prod.outlook.com (2603:10b6:806:fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 15:58:29 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7c8a:9ebc:e674:796e]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7c8a:9ebc:e674:796e%7]) with mapi id 15.20.5482.015; Mon, 1 Aug 2022
 15:58:29 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "chu, jane" <jane.chu@oracle.com>, "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: RE: [PATCH v5] x86/mce: retrieve poison range from hardware
Thread-Topic: [PATCH v5] x86/mce: retrieve poison range from hardware
Thread-Index: AQHYo9wytRYpFg8fm0OMvCzhpbWWKa2aNUGg
Date:   Mon, 1 Aug 2022 15:58:29 +0000
Message-ID: <SJ1PR11MB608393FA8D4FE8092A84D53AFC9A9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20220730061757.3441537-1-jane.chu@oracle.com>
In-Reply-To: <20220730061757.3441537-1-jane.chu@oracle.com>
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
x-ms-office365-filtering-correlation-id: 3122c9bc-bcdc-4bf0-1780-08da73d6ad43
x-ms-traffictypediagnostic: SA2PR11MB4940:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AipO7iGhI3Ch1765fGE6w51r+YwySNA1cWuJrwfQ7ws+gpPzoMWxqhoXV3auWb39axSk9HWnyYpwI3MPbgP2Ja4ElXlKNiMuN2hWrH4ZY5KotAeEz49Tu2dDixq3w6gjU+75lfSYONaTcFgw4R1g1MaGrDYsUo9Vte3RkAxXkyx/Db5VBvDMEsDML1DPKOvmZsHXP11lgDF5q2fBZxhEmYZQZHK3juCVibwf2V4tqwr9IOJy6NmBMF1uI5ir7aaXDZ+cX3gi9Rx7MbmkVRgR8krRXArvmu/8R18q3F9IIRJs5fVkYX8r5IaVie7OuASgwMs3sNQ6Ep5jXYD5RCoWLQouV7ZLQ0sJlYi1lFvPrYdWy/x9torr76VJIWhR3Mbpf+seMt5+pulkVp0Q+SG+s6sLisUBIugXIXInhiELksUpDh+cGxfnkqcagGldpz/2JBfhUq4XLv3iedzxFZNHyQmbdCiMatNag8yrIiTM3qSmKJy5o9sNWyJYU69gW/UhDX+nO0gCAhGuNCAPcHcbQ8ltqecDKeaut6mEXGFmrluJ9BC+KwKJp2y7tzV94QnjQl3s4VvGVitzwV/T65CKAF8W4J2YDBgD0w2T0+iH7MmXECf1Qgz4sB5CLyXAAL5/GtEfFN3hP7HpU3Ya3n0luoF8mxy/UDGFEh5uliPJ0WS8qdZNYABzDAYu2Ckjc+Vbhm0P3NtGOSo9KWa3ebT/luyOmEr+/EzDTh15WqfRs3aBgazDWFIMuCytIqTIW2pbhAmq2Fv3m/p3WgfdcsCJ+DkE51S2eKxal9bYbRAHJiwiQ/+VVbxsn8LRHurXRODoOCY1cwYnZ/HK+7T0UdfmtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(366004)(396003)(346002)(2906002)(41300700001)(33656002)(186003)(7696005)(9686003)(26005)(86362001)(6506007)(921005)(38070700005)(55016003)(82960400001)(83380400001)(122000001)(5660300002)(4744005)(38100700002)(7416002)(52536014)(316002)(478600001)(110136005)(8936002)(71200400001)(64756008)(8676002)(66556008)(66446008)(66476007)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KberTEYBRvIDbcRv2OCCFjlf6SDuOaJZNIp4mU3F4YnQtbQDCHsSBKhC3in2?=
 =?us-ascii?Q?BQaKgaMdcqmakGQxPwdg882Pqe4Eays2tN6UbP3r+01dgydIcIXxqT50FKMg?=
 =?us-ascii?Q?dqWiUBqAqStSYz9lNK0dmSrjpc2XON8TOugzUZw45TR14625YW6xIu2u8yW8?=
 =?us-ascii?Q?cEejXq9J6GQThJYs4w2kdtcozUb0oe5i9pbQOumniLm/nUtpstKulAYcmaqc?=
 =?us-ascii?Q?AiE2ATi7vUVxrpfjzqxG15TA6+73M3HR+3qupN34sFnofr7Sq+s/wh03yPvV?=
 =?us-ascii?Q?pfzBhcyQ48uNYpHDL+hHwQc29QZB/rzbJx6aEo4VGOb/gq0z1TqFIb4ovH1s?=
 =?us-ascii?Q?mAUALQ9djlBczMubxEHzcqe7zHa36E4uW6c1nbjPff2mt/9n/X2nFiNtqYtg?=
 =?us-ascii?Q?PuxzfnJ2no18Yzi61DnXbDeRvCoIDQ1eW6jrkpY/PzKMyals8YbckvNsf7ld?=
 =?us-ascii?Q?mlWhzHXzl5R1KzLnCbZFAl5KJXFkVMRg1LTSN2JUH4QtVrU+3LdGtdJhcw3/?=
 =?us-ascii?Q?+IUMvI0ueXw5xx1bLLvLjhPwnaUbc6ZtiCJft6sukdR8r3Ku8VR99DrlPuJj?=
 =?us-ascii?Q?P1H8jL73frk+jC8NrW43maJ+I9YSKupnAExrWN2lWhJAzQHG58yR6ZzUEtw6?=
 =?us-ascii?Q?DThM+WPxPFUH2dclNa+mBRAN8rAluMCkcP40p92yICnm6YP94RUp0YsN3qKc?=
 =?us-ascii?Q?I+se2gYaQpBkXLSJHT+3WE1TMnDcV2l7ZTeC7o3VmldAoHwY9yVWXnhEPb4e?=
 =?us-ascii?Q?CJqx1Ht60XGHHpyQ4OvqsVr6Gncla9FbmXU2XFBcBPDr8EEGVSqIiSkAi45j?=
 =?us-ascii?Q?k+2d1XS9IchQpmSRSV9fjeHWjP4pCVZ4wf/G4MbWWOq0xZtfssQBa+JED5TH?=
 =?us-ascii?Q?jO7VLCmoju3MfAAdaJHBkN4kybAwG9aWi12QSnm19cbchtMPysMFqmSNod4P?=
 =?us-ascii?Q?09sxdIy6sjSNLcSu5wTnAIdb5HFurH3jHUnWoFutKGQjQ+SA6MdYXlV379IX?=
 =?us-ascii?Q?kzqYwk9L6v4Zp0XFroN/OSxPtRE95XV9I989BRFOf5dO/sUgmEllJFO83tcG?=
 =?us-ascii?Q?nbh7Ajc5B4SzRMSIA3xuqQD1orOd6srOO4yQ/0HAIdTkHD4W2ZWVH8OdSHwG?=
 =?us-ascii?Q?pnQJHCwfkX+0F89fkEI7MBgCdQi8L7w0jt1XifZue77M+/hJpqcRGhdSQ4YL?=
 =?us-ascii?Q?5P1GQZsfuA4w+Gr4eH1z/GDtkJ3w6s/5q0xC3dq0Md3GemUv4UQiTa2QZRf+?=
 =?us-ascii?Q?Gb6N9ptQlZJvxI3rwV2Viw1t+77N4X9+Z7BlrEgQdswsHS5QIlnAtnzvZ6DY?=
 =?us-ascii?Q?G7XafuD8a+jttPTuYX/Z72GwL8MygCKQdvEcv9giZ0yVCu5bvfetZ+58ARyg?=
 =?us-ascii?Q?AYvyl7dNtd5npVA47ypx3sgZ/ArVYiqUqQChJP/+DpP83sJ8c5YT7Cu6qXDL?=
 =?us-ascii?Q?SnJDNuS05lxg4S/NeD3oj3HrLmKLGW9jK/JitXuu0GCGpw/Cw5+KPxnbOJMU?=
 =?us-ascii?Q?wXn05jnHPNH5CI3tJgebofx+sbwyXGhl3sL1dBhfuJoMRog7xT3AwLzIDJiE?=
 =?us-ascii?Q?AOvToqrRt2q4yutP5OI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3122c9bc-bcdc-4bf0-1780-08da73d6ad43
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 15:58:29.2928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vAKl1H6JuvP9gBuDyuqueXqXCUNMfG+paa3WNH7CO0DeDy890ofyhI9AZ0XvA/4TebEReTiJ1FVlE5amxs0zfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4940
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

>	struct mce m;
> +	int lsb =3D PAGE_SHIFT;

Some maintainers like to order local declaration lines from longest to shor=
test
=20
> +     /*
> +      * Even if the ->validation_bits are set for address mask,
> +      * to be extra safe, check and reject an error radius '0',
> +      * and fallback to the default page size.
> +      */
> +     if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK) {
> +             lsb =3D __ffs64(mem_err->physical_addr_mask);
> +             if (lsb =3D=3D 1)
> +                     lsb =3D PAGE_SHIFT;
> +     }


The comment above __ffs64() says:

* The result is not defined if no bits are set, so check that @word
 * is non-zero before calling this.

So if the intent is "extra safe" should check for that:

        if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK &&
            mem_err->physical_addr_mask) {
                lsb =3D __ffs64(mem_err->physical_addr_mask);
                if (lsb =3D=3D 1)
                        lsb =3D PAGE_SHIFT;
        }

-Tony

=09
