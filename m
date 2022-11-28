Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CED63A0E1
	for <lists+linux-edac@lfdr.de>; Mon, 28 Nov 2022 06:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiK1FtI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Nov 2022 00:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiK1FtB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Nov 2022 00:49:01 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782AE13E1C
        for <linux-edac@vger.kernel.org>; Sun, 27 Nov 2022 21:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669614540; x=1701150540;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kXtu7XYWM1RU2tNi/e83XOYCDOoT9U4ujtqaE0tBtBA=;
  b=NTisdgLZmWnNUNXVOpTRTUxlW2erUIm2xLU2m/PFdX/qqrgXAxi0LBVW
   xAzT/3c1+tz8yf+aPN/ng2twRHR55c3oONcFdSepACjD9txGyiqrczuC7
   PBiBgCOklY4oviURdHgAXe1aDtQ5apg7URj550A+XyN3dyOafRuRTOm6O
   ngItgcCuCCrwDLd0cNpy3KZNXWzmRxDHGbLtpxs3cAXoLz/Sxbm72VwcK
   C1Rd2Aw4nc3+OFBJO9fBbM6bWhs2pMuIrqL7WUd5Gmi4Rgk1ri31905aJ
   79UMkGtAB6jji/TRUUR430TqilDmxH1BYpOpAR0U+GTw6ncORGtyebJ8j
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="315907723"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="315907723"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 21:48:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="817696144"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="817696144"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 27 Nov 2022 21:48:59 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 27 Nov 2022 21:48:59 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 27 Nov 2022 21:48:59 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 27 Nov 2022 21:48:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTcEQmHWQe3v3onVBEEsRYuIuKrVpXsESzjKUizrTdl8MWk4/FccKRd+uIkjykcDEirutX9+FPrFkjQl3HupYJbQ+jbcuuSfwH3NPVdvfUBhBd7CnXmnCbt6G7+H83bD9rMShL4eFSPyY4s1HF2ciHNGflUI9lojzBoqY3SpCmPKKczyrwqGG4WvWfQnt0ZCC2Ilkf+5BcGjzsXCkR+657AwwFebZBmChtmibCTIOSkXEvLvbv46f+VFU+iIKUMJC52EwtEFGu//TbnvtDCMKxLESxpgCsS//YU8ZG8Js88v2SN4Irz9g4P+YH24O74SQyjmHMfCTzAgFQmWiowe1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6qafnbFa8QFxDzW64mh6pmM3lytcHuphd6qx6508Wg=;
 b=NumGo7qkn5bbY2dA9P8cIWEYy3Mit2KRkIM25kWooZ2dYaaKvAB+CXEFfnoeYZ0ysF3TyTfVOdOLGpLZESnv79SR2fb2Jsa6KLvbCD5Ro4WIVg5WNCyNyw6OwGhcOpIWZJ2/vlc67Zjw0N++LMgi7ac7NDJZ6W4obtoOrjU+T4zLOTlv/K7FnFvHobB9RlQZGf2ixoWTDWPKNHYSlCuFY0WMldKuyyn9PPHTFY0Y28/X5VZNkBsGgp+BhOakVXQj55oXDogkk2KDD1x5gsJUPvclxbbGeidy7fdy3jDE9SnOyENPWgrJ2d9qri6js2yLjtHGD3pjbwOOzm6I81GC8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by DM4PR11MB6215.namprd11.prod.outlook.com (2603:10b6:8:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Mon, 28 Nov
 2022 05:48:57 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::d204:9aee:594c:273e]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::d204:9aee:594c:273e%7]) with mapi id 15.20.5857.022; Mon, 28 Nov 2022
 05:48:57 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Luck, Tony" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>
Subject: RE: [PATCH] EDAC/i10nm: fix refcount leak in pci_get_dev_wrapper()
Thread-Topic: [PATCH] EDAC/i10nm: fix refcount leak in pci_get_dev_wrapper()
Thread-Index: AQHY+lYo+l/opjpjO0K/Ttn73Clk5q5T3Y5Q
Date:   Mon, 28 Nov 2022 05:48:57 +0000
Message-ID: <IA1PR11MB6171535C90DCDEBB263417E489139@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20221117072620.3931912-1-yangyingliang@huawei.com>
In-Reply-To: <20221117072620.3931912-1-yangyingliang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|DM4PR11MB6215:EE_
x-ms-office365-filtering-correlation-id: 3e4552c5-dff2-44bc-f08c-08dad1043de0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7fHd5XQLIgFkf1tRCulnwFzv7bURIsH4Vp2Zqs0f9d1lRIeiII/iR+r2krOgR0IvFxkjb9PoO0P6aXDaaKhyw6cTXtI2AzMK33Nr5In5bSVJEiF3hiJ9RQXPjX/AgteYgU2Yp7umOXcJnQyiMaXOQ/3hInIYjo0R5VizfRzqCsKKuzuaH9EirxPDsNvTnGkpIrvXkwgrF6J8qOgcXO5/1ro0rW6zXo3whvhzFCEgx+JZFZcATNrS5c6LffLhF930LViCQR8+w/HvmiFQnOpW4nzXoS2ogC3UW1+7RGwwq1ONW5PXtjjaJEjkP/k5xQfitgNhAIQR3j+wOfmzDcfknv4vNqcIVLCtopydNudq9Dmvl0iLYgBoSRIZgv6Awf0ienx5UAjZQZ4mCi5dGsg9E/tNd9w59dwmpcqktKRDyGXa4NxpNBeWluYld/diZJUTqw91k5lnxBGnL7+wN78JjgzCoKs2VSN4qtFPGEaGFHXKp9/YxFrx2cxgAh338UHU/Atjx4EyAhE/FEV9OV2tVt+ZAYgSxyfrt9alhubHJuVkfmttgcXclon0PMSPjXkttK6MZEHZMvt8b7JcZ5pkijIRjKItyTpFimlA3LJyo3MbnuFvh2aUOdg1K6Ppnb7TXf99M1akMpvYmWEx7e0UCcKxvpT/weJd8hIj9Fvpz/UQzMnagd0W7wo7ytqjl90IDZfHd6QIWWmeycEMkKYbwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199015)(6506007)(71200400001)(478600001)(7696005)(76116006)(66446008)(66556008)(64756008)(8676002)(66946007)(41300700001)(9686003)(186003)(52536014)(5660300002)(110136005)(26005)(4326008)(316002)(53546011)(54906003)(83380400001)(2906002)(82960400001)(33656002)(86362001)(55016003)(66476007)(38070700005)(122000001)(8936002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cp/bIecHzXIAaClI8qZOEIeatzfWp+4SbEjf1uEtMGxQw6W/Jb6QI8xMMhwR?=
 =?us-ascii?Q?5g4og4laQjbjmPIc3r/WfkEBqpkfLPzCRDxmRa18TUHjRqJibTiL/QNj6N0Z?=
 =?us-ascii?Q?bltJp8ZA9IPXLbVT+7Q6sSEhcXdPneVl72TzthpvJrE55vzMOKrpEofOMxAa?=
 =?us-ascii?Q?YTncp+9K1i6gbhd2DywWxZlZNvrKrt05lhHnAtVT261kgD0O68i3mAd6s7ZB?=
 =?us-ascii?Q?SNmyTUhUHvH3i2MyjDQLxUoVCKCbzdv6vzANHUTRbkjwlO+qzgZ9DsLGKmOm?=
 =?us-ascii?Q?pXeSTb1KaEsFTq/27uj022Hwq+jXbb6JQYFtxK50XUY6zPVQDISzzLVh3ny3?=
 =?us-ascii?Q?LGahUhdhEZWbV3O7uZakWOxnfXBfc12+b7DD9eYmWxgKnx7W4W9DZCNH8fSX?=
 =?us-ascii?Q?VlWoeOFzjBIIBvNWIvkBxL7zxiWYsDMFBu94IS1bc/oey0A07VZxFAZt5PCa?=
 =?us-ascii?Q?J54AWDk6b0yc/r6YbWDG6VrWNEYD2woy/2usIDVoa2SuvQLGuwBLFChPH/El?=
 =?us-ascii?Q?ZpUY2IaLy5dua0CxUlrYGzYmycBg2ZPxPPMb4ts0DiCaGudyDHfslXBifRi9?=
 =?us-ascii?Q?J9B4XU62DBpSSEXpUM19HQeR50hwSsy0JidDBRKe1VP5GWscm0VmxUDZFJiN?=
 =?us-ascii?Q?3xlA3a2ShYuMq8pyBgzGVDtbZSMOh3kux9SVsMIdx+BjMVcTeH1frl2+yXbg?=
 =?us-ascii?Q?R8ueFbR8LO+3GkJvK5ZO8dcymODLLq0QFAO1M9CUJ+8cl6loc+g3qVX0YOEf?=
 =?us-ascii?Q?zXSoIF8KVylFj2aSdwmP44Gdnk+r2H7hE7kBLP6j5omYLS2bfygNak08N0sJ?=
 =?us-ascii?Q?BpQPUmwOnph/Z/SiQOV9nTLu68wPOA/fHnj1ggQ4+sxlW8Euj3TG2+SxYPw7?=
 =?us-ascii?Q?sLccWZCkWfbg2Foq1q7ug10fHeuN9tCuxiKDZI56qkuFeZHIkImh63iu20rC?=
 =?us-ascii?Q?OTZhrzKks263qi/0uIO3reRnqkpTf1jBd+8nJBkbeeoiORuqAXqxB+nkWpxs?=
 =?us-ascii?Q?z2kw2Z/vZ/W1SPkoeoaBp0g808fsO8hj+3jrVn9S8yM29Cmq9HFmD/ko8b+F?=
 =?us-ascii?Q?iby8LnpUMSCw8wYBVpipK7rlbPfFjJMeJ9K8qKXWzyYrrwJLB+MaSmhdBqjV?=
 =?us-ascii?Q?s/PGCt1r4gkg+7u7A1456hSZKvEQPq/ZVfg+4583etGhXfPQKTT8kqIBVzpL?=
 =?us-ascii?Q?3+P1XKGtqGLGTJxC39ggt5sup2KcorlcKgOdKcepr49WW8MTsVjr3rQ4D1SG?=
 =?us-ascii?Q?jd1AIaOHQ46I2yblNj+MIgwNTO++KbCwf/QANW/l0ujgZ3reZAIq7pzmgs5L?=
 =?us-ascii?Q?AZzummt2KxwJuDSYmVVPhk6feGMGS07DB8WDn1xwgqvQjQ4jIZKzvuMr1fp+?=
 =?us-ascii?Q?ZiKRKBmi2A/Xf/T/1mC5FA6G8nB7iZEFCjLGLtk9DRlHwhDsblOeYgvmWo7B?=
 =?us-ascii?Q?v+NQMyKpA8ju9ueZi6Cjg2cou0C8G5zEBSq8SGodHEeQmR5UhoiDZjZ43rxh?=
 =?us-ascii?Q?6Ud7I/OnKOB3wgl5DV1A1cq7uezfXdhVIF+jajFPbEQw9zDBluwlBxFjBiz4?=
 =?us-ascii?Q?aCUiVF+D7p2rEDoYJZ8FRtgorcGLp1toV0qncMdH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4552c5-dff2-44bc-f08c-08dad1043de0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 05:48:57.3947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZIzwg9QllOzA0f1d1ln2p9SDeN1Z8+8/VPk9fDO2cbsq1KQzgcwF2UQ8FVYeRTU6ce77BCnCpKwobTs0XhTUCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6215
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

Need to fix the grammar errors in the commit message.=20
Otherwise LGTM.

-Qiuxu

> From: Yang Yingliang <yangyingliang@huawei.com>
> Sent: Thursday, November 17, 2022 3:26 PM
> To: linux-edac@vger.kernel.org
> Cc: Luck, Tony <tony.luck@intel.com>; bp@alien8.de; mchehab@kernel.org;
> james.morse@arm.com; rric@kernel.org; yangyingliang@huawei.com
> Subject: [PATCH] EDAC/i10nm: fix refcount leak in pci_get_dev_wrapper()
>=20
> As comment of pci_get_domain_bus_and_slot() says, it returns a pci device

s/comment/the comment

s/pci/PCI

> with refcount increment, so it don't need call an extra pci_dev_get() in

s/increment/incremented
s/don't need/doesn't need to

> pci_get_dev_wrapper(), and the pci device need be put in the error path.

s/pci/PCI

s/need/needs to be

> Fixes: d4dc89d069aa ("EDAC, i10nm: Add a driver for Intel 10nm server
> processors")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/edac/i10nm_base.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c index
> a22ea053f8e1..8af4d2523194 100644
> --- a/drivers/edac/i10nm_base.c
> +++ b/drivers/edac/i10nm_base.c
> @@ -304,11 +304,10 @@ static struct pci_dev *pci_get_dev_wrapper(int
> dom, unsigned int bus,
>  	if (unlikely(pci_enable_device(pdev) < 0)) {
>  		edac_dbg(2, "Failed to enable device %02x:%02x.%x\n",
>  			 bus, dev, fun);
> +		pci_dev_put(pdev);
>  		return NULL;
>  	}
>=20
> -	pci_dev_get(pdev);
> -
>  	return pdev;
>  }
>=20
> --
> 2.25.1

