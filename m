Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5F763A1C6
	for <lists+linux-edac@lfdr.de>; Mon, 28 Nov 2022 08:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiK1HIu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Nov 2022 02:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiK1HIs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Nov 2022 02:08:48 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED6712D05
        for <linux-edac@vger.kernel.org>; Sun, 27 Nov 2022 23:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669619328; x=1701155328;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p6NeqxIgTXdfmsa432LltMjjEaxj1xiv/fr/q+vAiJY=;
  b=mil9qB79JngpH8ezIoOQXslD1avmJ88x+ICGxci9VgGgZIJvQQRw8BKP
   +444ChwGmBbS1aflNbliMXENq5hjMS9yhZd4JtERzjws0g9mxyjlKR5le
   Xc2pticYFXMU2ws2rK583Or8uVVCd5VcjoDfqA1AGV13YNSGQdmrOBWLg
   ly1C7/raTOOXehae3x3EhL7CZaawJNUnLTqURUr6rz9v6pf/1B2J7RP/4
   9a3JCap1gjjL87dd1EnzwbXI06SPvhzcOq5kAEZE05iGMmWq0DYW04BGK
   ar/LOlg5znxATfUfwAbUsyFFSGPNfoYsGTliDeZA13A5uXHAqA96HMExe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="295147757"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="295147757"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 23:08:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="643287544"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="643287544"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 27 Nov 2022 23:08:46 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 27 Nov 2022 23:08:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 27 Nov 2022 23:08:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 27 Nov 2022 23:08:45 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 27 Nov 2022 23:08:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUN7k+w94hs06sRJTwWbP0AfZIJw7Ak1a3PkWUvBQGiLbRXDy+KAnSQXCPx1BrBWXxMAkRE3v/06xi5umIoCmQ/JCuo4SImPdcDbGbTAy897O36YYZVC4JLbnWQE8uqKe3cGFTTyajryP3z/I8GjPnSxGW32K+2l3VezAge7gSIvJLlG0QNwUj9wOEVewW2UI+ub7jTTaLVTsQXX5p/CJwFaRzMDoI/xZu6zUSSwIV4d/fL5EQYf3W4AkIChxMfMki6gU6uhNLn6iEoLI+FmwB01+2tDJDas8QplrBHOkRnKGjFQOZd4F+juw44mOMPlSjKPyGsTsaQVfMKOYGRnPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4YDnv+pKw3/gi+yl/9sL3xvPNcUyR4wdGQnRMkBKiE=;
 b=TG9n4m2kUdWQEm62MsVaOwa/IunkZAV4/opYmIw4F3cEBVaIYcqSoXPAJK3D20GU5CpqlTMEX6nn+rJBiJ93K2as/51v/leZ5j0NPal3UV+31NTZQEKvRxJ0VrlUNgCIBp8pu2iAbr4u6lWelx6vpPbaDp8scKmFcCTcHFA7VoehdZGjxfJeL4FpBveYjXi7y3EKe5lbuWslOLA4LnF8V423c/4GHSjoAQd+MOi7jP9lrGdwbq4055dVtPATI0/NgUy4erMf0fO/zP2mEmrvPQYZnIYrnV4K3s5Iz81fQHvUO0wvwFlY3jDoRfOZKxQWpMJcty7BGleyAaIR7ZwpYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by PH7PR11MB6674.namprd11.prod.outlook.com (2603:10b6:510:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 07:08:42 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::d204:9aee:594c:273e]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::d204:9aee:594c:273e%7]) with mapi id 15.20.5857.022; Mon, 28 Nov 2022
 07:08:42 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Luck, Tony" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>
Subject: RE: [PATCH v2] EDAC/i10nm: fix refcount leak in pci_get_dev_wrapper()
Thread-Topic: [PATCH v2] EDAC/i10nm: fix refcount leak in
 pci_get_dev_wrapper()
Thread-Index: AQHZAvawfucQ7Ilf4k+nsq3Q5mD7Y65T6kBQ
Date:   Mon, 28 Nov 2022 07:08:42 +0000
Message-ID: <IA1PR11MB61710C64A571586CB1AF08F989139@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20221128065512.3572550-1-yangyingliang@huawei.com>
In-Reply-To: <20221128065512.3572550-1-yangyingliang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|PH7PR11MB6674:EE_
x-ms-office365-filtering-correlation-id: 07e2ba4b-342e-4a64-c5f9-08dad10f621d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dCgHOnEtwmfKCxnJuBSitWTFS+2o/uFNioCPgvTYAGe/ek10S6WyJMhj062aW25O03fAfB3HwRsXcRsY/yqoc3Xl7DLoLxdNJl46j+rNFg8so0ONWHsKEhBOLTVaE2yii4wc0P5x+4L30Nd0pDdnJHDsgR492Cf++N4PJ+rwy4ocxyDNOxeLJIl8pMWAPkBJRL5sLbvd+p5BXf9YYVQjORRFYdQ8bOGSS0gnjsCKGCsWqvawfSgcfkPC/ANrZeBDxlWQANF/aMiO6jmdTOP0KHLUv5ihh0r9jwrLWbVuWVHM2A9BKlLDoYM5rG3bP4/acRIrFlL2+bixS1p55P4coSQw66sywVRNa1ugxgJseJuuGxZL8ntze+PUHQtEci5yuICGmJEg7VRqTOFikFdoeinNXI5p2/P2Vv663sEU8OBTQ+VkZM9BuFo89/zNJK49aSOV8q7QBHzL3E1jZgiudpLV2AzlxiFij00jpnB4yq+ek5HsAAzb3NIjdNFPSBBWrMYqY916WAYUnfU4RZKFqGlY9v2YxhkSzy6slB8MFH1acnz1DQKzOzyehm/JmJgPhnZx4pGZzJO4Bmtb+bduLJNwOqE0QiPBM8rFoqpbtBI2MEZeofQDQR3oU1wJM0KZYMgg7T4O+OV1eZxLLHgmP0d91IbHMM6G+yi1YnzfsiV8lud6TmOF/3a2n5ZV3h0uEE56Qndzo1T9jB+oZQ3ERg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(5660300002)(8936002)(33656002)(55016003)(110136005)(316002)(26005)(54906003)(9686003)(41300700001)(52536014)(186003)(76116006)(64756008)(8676002)(66556008)(66476007)(66446008)(4326008)(66946007)(122000001)(38070700005)(38100700002)(82960400001)(2906002)(83380400001)(86362001)(7696005)(6506007)(53546011)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vzklAX16rMViZAid99vJOYidMC1xlhgrcT0SwRhzwE8qQmqZnbC/iNAiIk/u?=
 =?us-ascii?Q?Hz5NBI2ku924lcp+veuuCnF9L6eGkwgRq8Vyhonv3uhxdZsmOHj94IR5kZB1?=
 =?us-ascii?Q?HnDioX4GEjbsz1yxJ/pWMGDJFU+erp6UNgQETqQwwE3o1wyELXnL4ei2AEz4?=
 =?us-ascii?Q?0LjMPBmhGfplEV2Bk0l10+UCX7scH9FlW6YCjicakHF6Bre+7WIEEJF1FSFg?=
 =?us-ascii?Q?jF6JcRSYUl3ZbROKyhS6FXMfJKhGOwzr0bKSZnRQHqzQN2ZVOG3TDOAgZj5c?=
 =?us-ascii?Q?2eRMqKTAiaA7gBKtMDo3FyxHefZOeuzl9SK8holsn3Gf/nNgWKDKHuPylL96?=
 =?us-ascii?Q?ajZCsO1lk8ZJdIoExGpvdJvAya1jtIaacBjpCpsUUycJEsSov/J3wLrq/XSR?=
 =?us-ascii?Q?FzqlmwiW1P33EHMh/33OcGEuYA/63lVmQjDnQpOf6LjVgEZ0d+QTZVOl7g/8?=
 =?us-ascii?Q?+Wg1LBv5cWmC2m8UY/AVca5ENQ5Sw9HudZ/n93xxrLjKd6HGY8xjRsvihPgh?=
 =?us-ascii?Q?5jZRrhLDx7gsE822q+q+b7sERRve+c0v3o4EtCBsy4vFJrvFG0RYQGxeaTnv?=
 =?us-ascii?Q?OqiHxSsiljmAjFKKWKaZ1bkHuFlNmtIr653DeCG5tIlJHHnlCfhi8j0HKmVd?=
 =?us-ascii?Q?K0dkSezwha7RCBm1GWt5z1npD5dAUmOxd0J515GFW4fp3WrDIqEdKkHSvYwt?=
 =?us-ascii?Q?G7+trvtXhjoB1Ic171/qBh/ZEjtjBhDZqP9kb8tZFEqdRw4KUyXQfM3Zc381?=
 =?us-ascii?Q?z9r3u7XPYTgnIOebqo3vRaRIV9ZzRpsILiZGgdE2aexzTEFvzjBGbgirf6BQ?=
 =?us-ascii?Q?AMY2xH9Z6CPj1HWzf5j0CUKfyO1qk7A/uyYsqVPuTN/jxf+MiHq1qh+rXGEZ?=
 =?us-ascii?Q?Ljwg+1oXFPrGMcHJPo+iom6+G4PQiq2T6EvE1xczhZ2cMNHo23qne7Gr4cxe?=
 =?us-ascii?Q?vIbj5NGHYQwmbKSlFFKrEpwLBBWvmE1Bj6pyhtn2BofQCQzbkS3/AIP009xQ?=
 =?us-ascii?Q?8nRjoS37mLrIlygvs0yZf7i+SS2oP8Bwe6Pf7Ii0pfFPUhdVJJ00rLFGneZw?=
 =?us-ascii?Q?Hw/r6vxOBNDLGCOvcQbr9yyQHgOLje1KYuw7FcRN9xiUHk5i1yE9L6H/AOgK?=
 =?us-ascii?Q?B7ZG46ccKAZ4Xdg7lf001Bg/aDajvT1SCp6KtW6yOLxOoIpVydGshI526oyS?=
 =?us-ascii?Q?akH5gmOhF5K4IkIqVMJ0ufSTXD+tDXecdI3WzgswcMMLkH7FXK5pEhVGh9vT?=
 =?us-ascii?Q?+GPzOB6RCwiz/U8n5SPmmG7ATZs9sipW8zkvxgXRJ/jM5gz4EnV/F8oS1H6I?=
 =?us-ascii?Q?fS+/dNxE+dpjNMmpn5L9mjbB2RpVO/tBbqxRyg1CK9DrXJSMDC3GOmfi5477?=
 =?us-ascii?Q?kofgWvzHdAB5J5ydMXJf4yNxDa6ixw+fn/OgRtEWfpjlwXSqtyOrjdHO+wso?=
 =?us-ascii?Q?chbWbJiBeKLqMvN7bz5x31JefpE6dnwIFIYtA52BYISGHbfloo36ObL4whnv?=
 =?us-ascii?Q?Yk6x4G1umN2f95nZtyM2rLZF4qBs/CYTimAvA22GKpnCTGzKabj5dRjlQg0F?=
 =?us-ascii?Q?DxBA8iir3of5vCvtSaQb7GuMckybGfZGXSI17GDp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e2ba4b-342e-4a64-c5f9-08dad10f621d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 07:08:42.6554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05yqZWYYuVGADGu2wJ0KTKPb7D/CEuoDp7BOam7t+GZsIybl5XaflIyJW8exRehqCUm+9MIsLPLdFGxNbLN0oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6674
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> From: Yang Yingliang <yangyingliang@huawei.com>
> Sent: Monday, November 28, 2022 2:55 PM
> To: linux-edac@vger.kernel.org
> Cc: Luck, Tony <tony.luck@intel.com>; bp@alien8.de; mchehab@kernel.org;
> james.morse@arm.com; rric@kernel.org; Zhuo, Qiuxu
> <qiuxu.zhuo@intel.com>; yangyingliang@huawei.com
> Subject: [PATCH v2] EDAC/i10nm: fix refcount leak in pci_get_dev_wrapper(=
)
>=20
> As the comment of pci_get_domain_bus_and_slot() says, it returns a PCI
> device with refcount incremented, so it doesn't need to call an extra
> pci_dev_get() in pci_get_dev_wrapper(), and the PCI device needs to be pu=
t
> in the error path.
>=20
> Fixes: d4dc89d069aa ("EDAC, i10nm: Add a driver for Intel 10nm server
> processors")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v1 -> v2:
>   Fix some grammar errors in the commit message.
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

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

