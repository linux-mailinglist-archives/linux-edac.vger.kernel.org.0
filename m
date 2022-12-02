Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA566408A6
	for <lists+linux-edac@lfdr.de>; Fri,  2 Dec 2022 15:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiLBOoI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Dec 2022 09:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiLBOoH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 2 Dec 2022 09:44:07 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC4BAD33E;
        Fri,  2 Dec 2022 06:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669992245; x=1701528245;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JoNqwlraeNAflnpssaeKFCGr9QJsNng4FUgy0pNlkjA=;
  b=IhKbvxPe9PoSCcaui/VQ/G2mu2WMU6zKI1SlHQ0lU7GCx3bABQhYhgWC
   VnH95ONqAKL4teG22Ih06G3Rgrwntm4eIXEShi70vthhAR+wcrFRhgULz
   m7iCXizQk41vDSVLesjzJblzzi5f8qY/mJGBsQrn14afjCuQRgwR0qxp0
   E+CtQwojk0FjQF0XPDuZ9mSzgoi7dZiT1+QGLH4rZhtncOFu1aHK0dItq
   6PzntZ4RhBpM7hVMxSe+C326V5NsgtjLAdhNbatf5rXUX+ktlzoeFlkYj
   4bpXb9RV6J4OZUD7lyB/BTn0WdFhZspxCZOP6V2wiJ2sxGF/l0flfFCCh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="317112295"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="317112295"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 06:44:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="787305737"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="787305737"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 02 Dec 2022 06:44:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 06:44:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 06:44:03 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 06:44:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QP7/jmnEDrQgvZZE+jT6h38Pb2aWwTD6zIEPA0+XmA942LpnQOWoV7bP7S1is7Ki3/Vpax576uSh0PDNbDuLI8l/kIrMfJyBPUN+c/juBzBfRK0mnil24MX0+pMGg2deN/34c9voeP20S/ZZ4D5ZjLism2DB0fDsNIENRjpoHHdMLderYSRFd3PObF+xPDIJEFa5jjK2vpfzVjvKEHso9/FyEsNrRc7U8GuK0gL607+Jr9uvV8EI2N1TeOYdvgbXMVCuIU721DzSOLMbZ8XyL5g8tUfK6OQkBC2gaccavXljLfkBF0jKtZPxSzOjnmcgUc6VMJrkFpyNpG3zFZGeoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoNqwlraeNAflnpssaeKFCGr9QJsNng4FUgy0pNlkjA=;
 b=RrqrqXjBOLxgz3/N4BXwq+9Kz1xXL8XciTTBgd1mNyaFyLFPXs2IgI25A/doJwYBs7vJIMt4+Lz0zcMMbXbwynmQttLhohwTkQjp+rH9oa9m/5XrokhsyRe03cBHtTgQY4MHS2Az6d7AHEyHRLJIBqz6yEPCV2HN7RfEB0qZwWSy2t+CDRiZQOqOq2/0IjHo/hFn5lfXClb3yo1TmAnGl/4DcOGjh+mfdGvv/Y+qreRI0XuP7ZpRyTa5kPFDgVbEQj2igx0C70WxlOLZpzFRY7frZCiDY+/x4q0Yu6k9jHe+3ulGNcgy4/3YdItEUJ+kGAhn5QMY4xBhKCenhSr20w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BL1PR11MB5496.namprd11.prod.outlook.com (2603:10b6:208:314::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 14:44:00 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014%5]) with mapi id 15.20.5880.010; Fri, 2 Dec 2022
 14:44:00 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mce: fix missing stack-dumping in mce_panic()
Thread-Topic: [PATCH] mce: fix missing stack-dumping in mce_panic()
Thread-Index: AQHZBiod8rBYaoP1F0+0JAoGaAcDUa5aqxsw
Date:   Fri, 2 Dec 2022 14:44:00 +0000
Message-ID: <SJ1PR11MB60830CE8C3F79C9531C8567AFC179@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221202163728.392509-1-linmiaohe@huawei.com>
In-Reply-To: <20221202163728.392509-1-linmiaohe@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BL1PR11MB5496:EE_
x-ms-office365-filtering-correlation-id: 02d5032c-dfe0-4c99-eb21-08dad473a68d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xx3aNrfnL7H7DyAzkB5W7r7iXY4kNv5VSAAF/w4aMHqbDqdrj8BqmmM3YZa8qZF7AdglULXfnsq2d7K16LuvfOH5SVvgjPi8kdhnM5HuKK2YALkT6GxzplIfZ/3Ttu4EcpKsW3aOtWDmSSMa4OltnTswemf2AOE0gp3FCY373GNx/6eDYTKefQIDCrHwLu3WEKS62i9wIbEkqUpAu/BP8N1K5Txqo9aQwUrCM9MSayrTU3WVM6Vkca338BGfeQ2kIdFHQl911+UjyXuJLiJrrYwhIVT0VafCkbxIpf1mT0m1ZgyGu8IATdXZOXUOIYIcoq18n2c+kU7HPGvObPzokeyVsLtQRQXVwtBu7NLaaKg4As7cU6f1LcQqOcjQL2GSlHRK807id0ze+iacBKN3BllT4yZvn0/kZDxXdZckKH0D46hY+1tYxdfovqb2dcBxWqh9jd2fvKuBIAa8ypXGimX9GQbAbwZWfGTRErVBFPdzvy/7RiUF8rU/LGEofjRncmFRD/o1AeshiunNhXPlMaA1ZFaC5AN012Kv7inFtVXdTcBhovmqcX4wDrfyuDQ4flspLCVYC4zqcYz1MqGadY4kKfWctIevrKW5E/DmmgLxtVscv+XSjNnOXyx5Zi4HWgSF2AYzV4Z8288n5jcKXQUPXYozVtZ8iJF5mtwkg5zMQPLv79qkOYkaScxSiFeQDTaMXcobUCT9kNcsDrne3KegL+wDESELFmfEY3apmFg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199015)(54906003)(122000001)(38070700005)(33656002)(966005)(316002)(110136005)(55016003)(86362001)(6506007)(38100700002)(83380400001)(7696005)(186003)(26005)(2906002)(9686003)(4744005)(8936002)(5660300002)(82960400001)(71200400001)(64756008)(41300700001)(66476007)(66556008)(66446008)(478600001)(76116006)(52536014)(66946007)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XWpSpj3gQyt41cZeCHfA5AeOnG+YmSkNfe54o7pXzyFY1VgaoQti+Tk8qNA2?=
 =?us-ascii?Q?ORrWjfGE7GqrZvLw8DOS2an7LhW0hsgs+qW3JcjH17breNVmxEn0KM7lg3dt?=
 =?us-ascii?Q?9JlThbJytMQtNhOss9XZAMZ1RItkvWa13cFdSeK1eBtg/bAmJuSMvR1N151K?=
 =?us-ascii?Q?4WXr09BrNR+Wbb8kMjmj/dRWCiSMVagP2ghv3HBO/B2NKtf2gnJHQSJ3OBCT?=
 =?us-ascii?Q?vhPaRaISlVMd0EpU9qUBESZxP65FT/z3RogykDZ4JswEQ64m52BY1gwGZorO?=
 =?us-ascii?Q?grABFdO0jJXrk5zLnrigb2XjOJHH8gF4RVqEKCzAPHbVCZeLsJ5+H1sF9trO?=
 =?us-ascii?Q?UZ7stwmYHDOCDsCQkuPugKfKHfSQ1PjJpOTWtBH8mzfvTAHoWiB14KlEL8yp?=
 =?us-ascii?Q?8fSTaOWu3t+pQ/qyL8zU7+iNWHSxCDEPfsL+pLmg3oMYGLZDtIETdN3YzlR5?=
 =?us-ascii?Q?Qb5YnUeTDNNXe/4sga7QD96evZRmrcXtE1OB0aR0J4aFxKyOH/4g+Psa2+W9?=
 =?us-ascii?Q?FHIF/1w9VZ2rfCjngekcdXzocQxiRBgLktXIHTLeA9LdSaTEWK7gBceewOxQ?=
 =?us-ascii?Q?RvgObnBlB5WKp05ecjsYiXeYGH6TMl4y+o0lS1s9ZNVv18cfnywoFEgD8sIU?=
 =?us-ascii?Q?MzH2fOVD0QG17TJnj0FmYXncPMO/I3Pt/cRU2CWRQV9BG0Y2oH+/s7/yi14k?=
 =?us-ascii?Q?uXhPrtOEOzteTJRtmbwF/rJBjYZlRpLT9qnPd6sIVokiHgKO232bzA2NFizG?=
 =?us-ascii?Q?NCtpd8Dsm4WlNTW7IUkGaS1qDGFRfkb4HPzaVYu1lPUO2Suut0xKM8hL/W3u?=
 =?us-ascii?Q?GpHc6XmaDIfRZGN4vsuJ51ufVLqufWTnLMDx8T3gzm4fEz3VMSkjMZMtuEXE?=
 =?us-ascii?Q?pjmb3Zv37FcknMlNurf0LMA+NAWbus8RTrXV/BlXuGfKBjLr2uu8p8m298yc?=
 =?us-ascii?Q?dOFiW62f9iS2/hxVKwaQvY/qCCYdYBv18iawW22jgk+zUDz7N3k94x0SYDFM?=
 =?us-ascii?Q?10Qfwl90q0a4KS5y54KxqjmCQp8G3Ut/nZna/EuFFfKoiw7F93+RLjPCOipZ?=
 =?us-ascii?Q?ZrrbaIDLqctp70lMtQfBHKeNX9B9Bm1PdQSB3CRof7jlm5SQYkhJ6DHnA6FE?=
 =?us-ascii?Q?n8G4QyNPVt1O7hAele3DFGWsnsVIt/MHDIDGe+UKf+5T+GzYp+xajZpNRXoj?=
 =?us-ascii?Q?tTiUILAXtfJrv/f3NDpze+MZLJOuNCPywkKMs/VtWzuxSgNBNtFGRL0VnFNr?=
 =?us-ascii?Q?mWn8wQwYtOM9UvABlg0oaYUQ7qMb4SMkpneQrS1jlM+14WrD5aTC9/8eJDaH?=
 =?us-ascii?Q?a+PbiFfbPffEESvkfGp0Dlgh3cGUx7RcSXaYfCCvhmudvRs+nuIEsHYR0sQd?=
 =?us-ascii?Q?Qcq9o/9cJ4gosXPk3I4XMxTBnX1ggT07tNWpumJMRp/9YksajrI1XejL2/YH?=
 =?us-ascii?Q?DH8JbosZEt4TkEPDh3F8z26yEDW8omfuEN0vwGSZLHHIHO+U8grbxbL0/BPB?=
 =?us-ascii?Q?S/P+0PZyycCx49OzAhJglqLcx8mE2b8jp4zIP0jDODH+G6b/TJy2khsmZ/Ck?=
 =?us-ascii?Q?u1JYwsWQCWVM2o6dMttzCYOtjJQ46hNMXHwjqzie?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d5032c-dfe0-4c99-eb21-08dad473a68d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 14:44:00.6524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8J3ASDzFw8TKmRSRBZV6u01wrI0FW4CaT0pIxW12yOV72DzTZZpCfk91CNUDPBwtdfPtnwW+aLx57mjXwS81dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5496
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

> When machine check exception occurs, there is no stack-dumping now in
> mce_panic(). It's because bust_spinlocks(1) is called prematurely so
> oops_in_progress will be >=3D 2 when trying to call dump_stack() in
> panic(). Thus dump_stack() won't be called as this is considered as
> nested stack-dumping.

I had an earlier patch series to just dump from "interesting" machine check=
s
(I think the interesting ones are when the kernel hit poison in code that h=
adn't
been tagged in the extable as recoverable)

https://lore.kernel.org/all/20220922195136.54575-1-tony.luck@intel.com/

Discussion on that fizzled out.

Thanks for tracking down why panic() didn't provide a stack dump.

I'm still of the opinion that stack dumps from machine checks aren't
generally useful. But I'd rather have extra stack dumps than no stack
dumps at all.

-Tony
