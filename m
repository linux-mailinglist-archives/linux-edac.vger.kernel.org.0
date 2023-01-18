Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07636712E2
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jan 2023 05:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjAREzW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Jan 2023 23:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAREzV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 17 Jan 2023 23:55:21 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DD350840;
        Tue, 17 Jan 2023 20:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674017720; x=1705553720;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NQ6iAIOU+x4oXp55bhwwPk7voEaez/ZJZMH41QBGyLc=;
  b=YQ1Sm2B8x48jUAgAP0DIcIVVKY/D0Zu9J4j6cgOuXJqgmq6pwUYwtBw3
   GFo0jOsvpmXYi1rLx+a2v5C9ir06qLCbhKCnSqemWGQDeC345wBD80R/8
   fH5y347JA8vsMEaf4IAZmYHO89S84ua9sw75+WXU1QIpfgL09kDEz28nq
   YvGZJTIJ6soCdEqQ8cF5MpT/EekdujoNCuKO9tIs1PAGYHnzlB5f/Wbh6
   BAGBIAB39NInCcgPJZWDqPJPmSuGtwL4Up3b2ciaDv4wUJ4D6CoIuKCzo
   YSeFUySE4awomcLWTsy9vJZ7lQBpr9RBUVVLShY9ypp0K0nYsIaU/PxXp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="352143769"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="352143769"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 20:55:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="988397882"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="988397882"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jan 2023 20:55:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 20:55:19 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 20:55:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 20:55:19 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 20:55:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNG8n6LTyutYv1M1KU0wBoSrrtJN+YkZQrxjvJgkxPwp4W0q6V0v2Y/43hl6kpAIom0F9jNOMv5cjoCpqKHUHaplvi9LvK0z85caclYjn6j/th5lBNiUIrhUKmTzHRnDlnOlyb6KYgxRql9QlnQwY6Hg/2amSAsMZQV1uMEA32hVsxdrJcJBKyC5mdUv2k8Wj2qg84P59dLYU49IJOEoR0vpkfPEO96pnnoP7M+ZKV6HBq6iwqGVkUb76Z3/XX/Zg8dTdd+isbVPGMvMuFBr0efPVssPZmimTnKRgNYJDtTenpKGhSu2qzdGJpISixTuGCIMWZH6ZBogghFH2xlYog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Prbv58+xB+vK1u1ON9ZoXRFrDfYwcE+LqhKPw/zECA0=;
 b=nE3z68PKveC43DU2BiYnPOo/AdY2i9JlnnQpHBrfSjJmGi2gs6BZhkh7ll0QoxYtfH61slg1dx7QAzJLtqPouEhQ0OTD1Fz3L7Uf/1s4WT8+sNMZPAogOrUAxiHEew6dMEa+ei7toxdeaVjHYvdGaL25uIPgXCi1YwrUNz8jKqRZ4bQ4u6kLBUoFuNolYQANMV3E/Q7E4ZKYD0C+ylbBfbh1l1wAqWFLkri5jKfrpdM/laN2JCehfpNUWwGPd5lmQHchIKjShnJTNJ3Tx3MEvRpKm248oBEdUctLwRrJLMjWMfwTVAHc0CqrIGTGdxI/0V4XGAAp8EHmIaWcxblGMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by MW4PR11MB6690.namprd11.prod.outlook.com (2603:10b6:303:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 04:55:16 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::52f:ae62:7fbd:600e]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::52f:ae62:7fbd:600e%9]) with mapi id 15.20.5986.019; Wed, 18 Jan 2023
 04:55:16 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Bo Liu <liubo03@inspur.com>, "bp@alien8.de" <bp@alien8.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "rric@kernel.org" <rric@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/mc_sysfs: use strscpy() to instead of strncpy()
Thread-Topic: [PATCH] EDAC/mc_sysfs: use strscpy() to instead of strncpy()
Thread-Index: AQHZKtxP32uekMILf0+qIys6Wi1A4q6jmYkA
Date:   Wed, 18 Jan 2023 04:55:15 +0000
Message-ID: <IA1PR11MB61718652054C38D8881F3F6289C79@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230118012906.2376-1-liubo03@inspur.com>
In-Reply-To: <20230118012906.2376-1-liubo03@inspur.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|MW4PR11MB6690:EE_
x-ms-office365-filtering-correlation-id: c5a1c24b-7ff0-4c8a-727c-08daf91030ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vkf5s0nldgUhcrCRwMA/CVsia3wAL38zisdt4JTNDItI3txTQvOZm6sU7awFbSfStpYbM+2Y6nYKyBWTwqSABP4489csMDYclzikk+0Rjjqkgh3DZ8v7Idbx+WI/aCFQPN5Ss41Q2ocEEHWsN4oJApQ2rjTsioMdSl70OLdf+ZsjDZlOXQQKhQUc60v11xUfFHd7P4WDwt5xmHpjkAKMD21aNiQlXJrpRuMVpPl/U11yGITLw4gfhYfm7DtdkdLIk6eWB76jWZOvnP4MVhVNYyJNTQUnfgMrgf72E97gE0BQ5jQwp594L45SUfSVfk3CBgbuGEyL8pP8rQoF20zrj6dLBskRt3XAN5Up2OUEkuIhuKpiYNK3Odxzt6zI5PFURl5Fwzst7RFHCwzLTDFAoNGnCuK4qEtdTIIH053W8j3wifQ7k9MYNXWLXLgd4+fTIJGeq6FLmf6SN84REXT1Mxt3k6vk1PIuIUqq/FjJfB9A6avjzyPtb6gr/yt7s0hpsZNYtWCJJoUbVpOD9qwE+k8R6pUc8Fg4ykTKCX8doZ+BmEq1y8exu+o/YhX0UoG65ccUALljugIUdsPdgybIVNPWBfSoqq9PhFBG3DvXd27AIT+X17dk+VQ3ow1ry/TQUA4TbwI7VyeIotK+WjCPSqG8vIog9rbBuf14ImJDefhzEx+wh0DqDS39PLTRq6SumlywatE6bR0AXn5bXsI3dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199015)(8936002)(52536014)(82960400001)(5660300002)(71200400001)(66476007)(4326008)(33656002)(64756008)(66556008)(53546011)(26005)(41300700001)(76116006)(8676002)(66946007)(66446008)(2906002)(316002)(6506007)(478600001)(54906003)(86362001)(38070700005)(7696005)(122000001)(38100700002)(110136005)(186003)(9686003)(55016003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mX7Q2XeHRtvBHtqjC44sHAU5gw+dOKzEJstCNtCxdRHgfZuyrWkXE7fwUceU?=
 =?us-ascii?Q?VfIpAlqW4CR6+G5TlK3GzdcJbsUjASwUSnT1NafXUZ8ebEXG3NQ7kqQzpyCi?=
 =?us-ascii?Q?HWjL7qPmui0ojBqeif8bim4O+Ddiab4yAv86DEsvRjbneH/3ugq0/Fre7yrD?=
 =?us-ascii?Q?ucPuRZJnWzm0mwUw8d22HB+gSakRvmBQsUiIptffxWedy2arfKCXbJi3vI0M?=
 =?us-ascii?Q?z6GN4FjJKjvuzgSfiJe70nWUH8V/Ck/oZkeV9XET1B/O5gNYAqDkeo1Q+AkA?=
 =?us-ascii?Q?eDzosL/SvVgkXDNBNij6kVlVvltPaU9jxVPI0RjZ8c3KHWcvsUGtysSwLiTX?=
 =?us-ascii?Q?Z9glHDMEOMSFPtS2Sc4Ya6EsBuCjoQOEPJmGIqfw8LamHXWdQLQtWR9fHYn3?=
 =?us-ascii?Q?Pvwnf4vAEpFC2V2vXyXkd50ntgYS4kJuUdwNi2Q3/5kV6QVfZBkjpdqDOvpw?=
 =?us-ascii?Q?AVoXGDjGHeyzOAJCHLgJbAVqIcNXeovxtVpJ1tk/BywaukuBERg7uXKz6PeH?=
 =?us-ascii?Q?fYecDFbmbzLnXZBE1szR0w3B9JbatPvseUtQETV1aS1Ssk8qns1pUjrFpbxq?=
 =?us-ascii?Q?7eonn0pHbTDDR5i0C7wTDLOv3S0INkEJsbkMgLWE8N6xdAqGLoIJGlnKSY5Y?=
 =?us-ascii?Q?71q5mY8c458q15urQegY+xhBwgxsTB88fEBj2XkHpCzTIa0tApnFRSYSZlsW?=
 =?us-ascii?Q?rHvIm0RQBP5Am8xL7hwyh8ioDhn9kSRBEocxKO1m8wf69Z0s9F9gicQgHvbI?=
 =?us-ascii?Q?BbqVgAtsQcPbZ0Q+15HQ8c5JcSEKgemzX8X1aprHf9iNfL86HaKBnwk6GPYg?=
 =?us-ascii?Q?Zi0FSZ10hORNg8tz3+W6ctihtA28njXfHcrh0B6nl6BS8UurA9wA+PWp2Ko5?=
 =?us-ascii?Q?RdwDZxxG5SUTQ6VigstCWCQKM0KBdUUDq6xfaEc2byJj9zDlXVx3t2gUJEgq?=
 =?us-ascii?Q?ft70rqUB6M6E6zce2N37EBFLCKvR9+EtL1UQ5Y5P0cqxB9w/0oIp0lMWbLul?=
 =?us-ascii?Q?dPb8O0YDqvo5MKtVw1ueEMFMNFwjFD+NpvSr1rq8eb5GaLvHa0BR0BbEWew7?=
 =?us-ascii?Q?DVjmCOyGLgkHHDDaaSDBlvAdwBD9q+WsF3WuP1iI8R+ZVZVjTcoGO2+xZrTI?=
 =?us-ascii?Q?NJG6B8gkfzdXsYM+3nNbwZs1dIUFA/xrcnTGnnU+FJdxNH3VJ4UPh6MVNoQ2?=
 =?us-ascii?Q?pdZTnJXb+OuVcgiQuCSCGA8jhK0enMYeteEFapiaFyJB9iKB/wpVWiVp3UP5?=
 =?us-ascii?Q?sYexwbRGrQrOs2KTUpl2ISgnsAmixDQ8m049uBRwh+3UgM0LpUtO4rs/zvYH?=
 =?us-ascii?Q?n9NZjDBwtMBXjGPZ8GK01oacECj4ax1eQNPCuQ5cQI+BSCr5KF+PrDQTLuJ1?=
 =?us-ascii?Q?6Ru+c03Q9qF+XUvGvwch+rGCLLDaslcGIO9Aw1b/v3MpqJFpS08/aDYHfera?=
 =?us-ascii?Q?bP4hUIF9D5IXljwYmhzVSssvBVfdy/Dv76ZBXMeu3VCPUlpcVsRzln14cP3H?=
 =?us-ascii?Q?wpV5nR16ZdgFVh68Rk9Yvmfk36pYpQOla0lbhdW0jhuVcyHNrj6HWn/yHg2n?=
 =?us-ascii?Q?zkVd+1GGmlTgEl7lS4aqF473J/CkRKAJ74PcRM5O?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a1c24b-7ff0-4c8a-727c-08daf91030ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 04:55:15.9557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GAwCToLU6DeZs0uwfq8ghLoGIzDGns7+MNktngoDZ9AI8+YlgrDWR8YS50k7YzwmLaSAezkTUMjnQi/CpMGl6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6690
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

> From: Bo Liu <liubo03@inspur.com>
> Sent: Wednesday, January 18, 2023 9:29 AM
> To: bp@alien8.de; Luck, Tony <tony.luck@intel.com>;
> james.morse@arm.com; mchehab@kernel.org; rric@kernel.org
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; Bo Liu
> <liubo03@inspur.com>
> Subject: [PATCH] EDAC/mc_sysfs: use strscpy() to instead of strncpy()
>=20
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL terminated strings.
>=20
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/edac/edac_mc_sysfs.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
> index 15f63452a9be..b709cbe8dcf9 100644
> --- a/drivers/edac/edac_mc_sysfs.c
> +++ b/drivers/edac/edac_mc_sysfs.c
> @@ -229,8 +229,7 @@ static ssize_t channel_dimm_label_store(struct
> device *dev,
>  	if (copy_count =3D=3D 0 || copy_count >=3D sizeof(rank->dimm->label))
>  		return -EINVAL;
>=20
> -	strncpy(rank->dimm->label, data, copy_count);
> -	rank->dimm->label[copy_count] =3D '\0';
> +	strscpy(rank->dimm->label, data, copy_count + 1);
>=20
>  	return count;
>  }
> @@ -535,8 +534,7 @@ static ssize_t dimmdev_label_store(struct device
> *dev,
>  	if (copy_count =3D=3D 0 || copy_count >=3D sizeof(dimm->label))
>  		return -EINVAL;
>=20
> -	strncpy(dimm->label, data, copy_count);
> -	dimm->label[copy_count] =3D '\0';
> +	strscpy(dimm->label, data, copy_count + 1);
>=20
>  	return count;

The 'copy_count' variable is conditionally decreased by 1 in the original c=
ode,=20
but 'strscpy(dimm->label, data, copy_count + 1)' unconditionally references=
 the 'data' in the length of 'copy_count + 1'.

Logically, they're mismatched.=20

If data[count - 1] !=3D '\0' && data[count - 1] !=3D '\n', it may result in=
 an overflow on referencing the 'data'.

-Qiuxu


