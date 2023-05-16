Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50276704E24
	for <lists+linux-edac@lfdr.de>; Tue, 16 May 2023 14:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjEPMxS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 May 2023 08:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjEPMxP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 May 2023 08:53:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2C4E56;
        Tue, 16 May 2023 05:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684241593; x=1715777593;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tvf0pni74bbADNQdILR5yaneT9nr1StLVe5keHwLBxA=;
  b=K1O6lUsMU4zzf1g2UXjNoYcVzSiOshmdEjN2DQDzKJ0MrbbyJoYxHagw
   I35rbdUAC+nWd/OUMdfPocWVj7qRttIbJlA0UStwzoOx0HTgTpBmfjVdD
   zPLYLAn97oCs0sDBUY0HoBeAhkn0mFhaL2+Z/9Z/duwF8ipgTp0AZ80a6
   N31a7u2p1zfZGyoN6Zl2tg+iYCHnIhoBjrrL1nPv90ESBV0Fa3M/IqQBE
   TtGkMSOoRznAQSmBeIAoCvrBObiGZVdk4V8czWgfcpIioc+/29fjmeonO
   rvL0epHQBerTAFI0SWWmaMnrRKiK185KHkx5pt80B12tWh855wDPQHPxP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="351497914"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="351497914"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 05:53:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731976776"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731976776"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 16 May 2023 05:53:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 05:53:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 05:53:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 05:53:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 05:53:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPBuOi8CpczUg0vzLQsubfoqZXsnSFqjcnV0FLsvB8skNNqxKEZY0icjYa6JBg/t3SL4bQe5MvhwzMLz49AOgVraxdTbKmTCXXVmvVLJCNQ/Z1AhPXnGzIgO30UE9KfEGrg3JGp0uBOG1+aR0etgvRjN2D24ORzQHziQ7SPptWbzPTm/Yiylx6HZxsKuhlzlDS8dNbOOHcJINmo97cAqUHkugdmjjHZY1407mbIFUx6onpz2dh1t8YEda0bdC+R639XEEnsPbcocdxsYbsAJBRPq0nus/qc8ytjgW8z8FTH4P8fFkxAs684P65OVKdVc065YNP7CzlTn4nw7jukXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTpq/RIlSxRtZnZbRzpPhghwc6mJn1mFhenC6hH2zRM=;
 b=QC+qOvP8QNxSxFZAUz9hw0ouVkaBkEYUnM5T/vhR0oXGUHBsobvjsEEiS49m6R3dMtUhX128RDwqcDDIbcOKJAcrB+6S8yQKwyDEPCG/GyyWpIloeaannUDz72fWNp7qWhXakQZlUY50Y+mtmoOTEe431m03a9F58Id6XmjcO2CXMki/DfWJ/hWKWAjHpGCfqNNuZiOdRr+kYnN1aH751zAb0kGlWZlwRd+Lv5vL6HdHlh+eFT/so3u/hIeIQ6Vi6DEqMjlqERzvtfkVaY3KE69rc3qpgd78XX1NBLQO6nUSBC1F7gE2Rgos/XB+UAjmPWxhxKfHiwsVSu+p8+sKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by DM4PR11MB6119.namprd11.prod.outlook.com (2603:10b6:8:b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 12:53:10 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::48a9:8a81:560f:4982]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::48a9:8a81:560f:4982%2]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 12:53:10 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Luck, Tony" <tony.luck@intel.com>
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
Thread-Index: AQHZh6cRf1tM2cXSPE61hdftzjZJ8a9c1sMQ
Date:   Tue, 16 May 2023 12:53:10 +0000
Message-ID: <IA1PR11MB61718EFB6DB1BF95CB1CEA5089799@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230516033133.340936-1-kai.heng.feng@canonical.com>
In-Reply-To: <20230516033133.340936-1-kai.heng.feng@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|DM4PR11MB6119:EE_
x-ms-office365-filtering-correlation-id: ed24c4af-4e98-4c0c-e407-08db560c80a6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /T2TKU+8FbFtneL2dDWp+sC8EFMD5ly7yzvFPBpciG+RgBnC+5We3LVrn2KDxLdmt4Huiz754TYRvGGYB/p9eTAfkvkc56UjMKdZZGitXNmTsyjAJ3Q1qftO+V/kYj/nXcgxYJZ8OsWe/4W7nWaCTYIQnSl6/B0NB2eIFH8n2p5uWD/hS9ge1I6ax6+adqXlm7sASD3sVoObUrcgaBTTIlPqa62uknqBn1tuXqCfVnsahH7ffeFLMmr/MrHxoZoAi1MI6bNJDe+xl1pgsU1tfmT+iWcqFUTZYRqdyLlTZaP8H5zZJhkWje7JVCj85hsLYs8Lpw+ZpoZcVqjscBn0rRDvNWuDrfr9ymWBoT+6DSR5q4lYLOkTDkC5KqFZrJ9Mr1n76983qdqr8mrtWuTDrGN+upi2fO5ZIqo8/Y8r6UADmLalLTpnNcbZHzW3x7wOfAEflxxz6B/9G3qCNUZd2dy5Mh7n2k3R9h+WZG+WoUcbIeTDORiK/x8gDNHCwTelHje8nxBa5T4rkc7vr2Nu19KOwrSNy5lLiYg+/CueRPGwzBL4r//7dvmCtkdbb1uqTelU/tQADrJ6y68WS5kuGVjG9DwfUyZjYw9qhKqetd60zcJaE/SipjiPrZNx6p9T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(5660300002)(52536014)(122000001)(82960400001)(38100700002)(83380400001)(86362001)(76116006)(64756008)(66476007)(66556008)(66946007)(66446008)(33656002)(478600001)(55016003)(7696005)(9686003)(71200400001)(6506007)(26005)(186003)(54906003)(110136005)(6636002)(8676002)(8936002)(316002)(4326008)(41300700001)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5BhAquvgOnf6uOcRnvHxXExpHmN1vfLQAy7pKcOdO/y+/ql4g3uCnixX9c+v?=
 =?us-ascii?Q?GmSSo9syVm3+KKHAOxrnAxUS/r0LwPWUuk8j42/st3DpxMj2RWT5esFZUv9R?=
 =?us-ascii?Q?sIhx2e/2+nJ2JqmGgkDxKOG1jymn5mM6H0Q14ulod9OC1xpnF7Uqxa2pSxC4?=
 =?us-ascii?Q?s2x+JdmwVMkkKBL4h4MXrq/hvYAKNtgSXynoyMWlaP0mppzfIeRoff+WGt7d?=
 =?us-ascii?Q?TpLzENTeDlSUAcojiF3vQlq+fYbA/7O4TZ7lng1AmsdyQBOdwOtHbK7LSn0d?=
 =?us-ascii?Q?wJhiuSCz+I5pipCKp5yor3TTdaq08xx39lWrZdpCal+L3YErX4k0S3+41fgU?=
 =?us-ascii?Q?HCCNViDD2Mv3bDBWetjfNq4VAIHomWh5YBUoRepicmxFpE8unQ3gQu5OJkGw?=
 =?us-ascii?Q?hNCnkz3F22M4zG5FbOLjfQ4fAHd1P9VVdGIYd+Y1lccQ5qQbkAo9EHchkjz8?=
 =?us-ascii?Q?FpTejeEHbnOfMC0boWr0Qfr5yIdykekc1qofZtWiBIub60MKy6m11a2EypY9?=
 =?us-ascii?Q?CscX6OIxL5MP19jjZQlOYw2QlaPFLc9KTvrER47sjwrVUxXdV33M1HPpjoYn?=
 =?us-ascii?Q?QI3EZm6blYmBMU5KG9+0+LNtZoyv1xIsDTU7r0H2eInCtE4SDKMfe6z2pJMD?=
 =?us-ascii?Q?Br8MZkabk7FqWMn3orT59aADOXHDVLo4AZWxcoG7p3INjCRwVcxCnpyC1CqI?=
 =?us-ascii?Q?QuzwewOy4TLpkFRw5kp5mMy0TPniMSSPM9wf575VE5/XgULkXBSMhZZm8aCh?=
 =?us-ascii?Q?7+XSbNH5slPMWImuGkaT6V9XrRRc+fomMZzTgYDTDIs3iEIt8ea055mVEotn?=
 =?us-ascii?Q?cYbfCAWm07HfjtvYD+4lHAVMtzlPE7CpXUXAnI3ifAWYbvYbNGw/tgvSJQd6?=
 =?us-ascii?Q?ewT4+TlVeOrvfa46w6IK/rkd8EHL179zSpoyw7dFjZDYyXyLw+ZCWYZV2PEz?=
 =?us-ascii?Q?3vY5hUVYd3DE65PpcQVMVHNc9XPNNVQukPXlvwe2DCXw9kHUWF40s6vbXarS?=
 =?us-ascii?Q?fAGhmVnwF0cAul7Zp+kX+0lMONR13DHp27Zz6KjHOhJa5di8QcILLQcOb7No?=
 =?us-ascii?Q?Yz04aowGX3zivyFY8vT+ny4GH+pmcbegE6oKHuEtifS+HZtNmIUetjlbsqsP?=
 =?us-ascii?Q?0D5nCVjwlGbeY3EzuEAGTzOP493/qtg+KsBE20tF29n59GrXOY/QE1cVDoEO?=
 =?us-ascii?Q?ZNjy18/vqdmbB7btF85qJjUTZyhjEAzTVoKOfbPHvsGEfhfxbUct05cEQcd7?=
 =?us-ascii?Q?4RPFiumTU0avxvNbFINJlcrvVNOzsB/iQVkPRihvoYMgcw7TBSkLqDDMkKVC?=
 =?us-ascii?Q?pNRiisstzI2tZr1cuYeqO/Ug+Xaxq8bQgzif3KB5EG2Ybx66KmE0kIq7Uv0j?=
 =?us-ascii?Q?+zKNyVyKFRurhQfqbKQMhaiN6GqmLtsMzgjhba+VJ4i68DObL43IEl1Qd9WF?=
 =?us-ascii?Q?aXI8eN9s0dGtdB1ty9Ri5mfTwFGts9hvmyuASFV3zy6p+q2xuK6cvr8sdTKz?=
 =?us-ascii?Q?98lmqoqB6HhD2agYYlADRZsdw6BfMs6cx8ezTd1RM8QbcKToNiyHR/GsaecU?=
 =?us-ascii?Q?k/IwQY3+YHkMTn9b7IDKOBw+14QjUP4hKsEyOo2K?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed24c4af-4e98-4c0c-e407-08db560c80a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 12:53:10.1065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X6b2BbR+izzZAeglNVbWsBjBFui6QCRSoA097guitJ259ERtR2r6zR63qGyYac76yJ0bw/3CoSmM4qG31AnAyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6119
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

> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ...
> Subject: [PATCH] EDAC/Intel: Fix shift-out-of-bounds when DIMM/NVDIMM
> is absent
>=20
> The following splat can be found on many systems equipped with EDAC:
> [   13.875276] UBSAN: shift-out-of-bounds in
> drivers/edac/skx_common.c:369:16
> [   13.875279] shift exponent -66 is negative
> [   13.875280] CPU: 11 PID: 519 Comm: systemd-udevd Not tainted 6.4.0-rc1=
+
> #1
> [   13.875282] Hardware name: HP HP Z4 G5 Workstation Desktop PC/8962,
> BIOS U61 Ver. 01.01.15 04/19/2023
> [   13.875283] Call Trace:
> [   13.875285]  <TASK>
> [   13.875287]  dump_stack_lvl+0x48/0x70
> [   13.875295]  dump_stack+0x10/0x20
> [   13.875297]  __ubsan_handle_shift_out_of_bounds+0x156/0x310
> [   13.875302]  ? __kmem_cache_alloc_node+0x196/0x300
> [   13.875307]  skx_get_dimm_info.cold+0xac/0x15d [i10nm_edac]
> [   13.875312]  i10nm_get_dimm_config+0x240/0x360 [i10nm_edac]
> [   13.875316]  ? kasprintf+0x4e/0x80
> [   13.875321]  skx_register_mci+0x12b/0x1d0 [i10nm_edac]
> [   13.875324]  ? __pfx_i10nm_get_dimm_config+0x10/0x10 [i10nm_edac]
> [   13.875329]  i10nm_init+0x89f/0x1d10 [i10nm_edac]
> [   13.875333]  ? __pfx_i10nm_init+0x10/0x10 [i10nm_edac]
> [   13.875337]  do_one_initcall+0x46/0x240
> [   13.875342]  ? kmalloc_trace+0x2a/0xb0
> [   13.875346]  do_init_module+0x6a/0x280
> [   13.875350]  load_module+0x2419/0x2500
> [   13.875353]  ? security_kernel_post_read_file+0x5c/0x80
> [   13.875358]  __do_sys_finit_module+0xcc/0x150
> [   13.875360]  ? __do_sys_finit_module+0xcc/0x150
> [   13.875363]  __x64_sys_finit_module+0x18/0x30
> [   13.875365]  do_syscall_64+0x59/0x90
> [   13.875368]  ? syscall_exit_to_user_mode+0x2a/0x50
> [   13.875371]  ? do_syscall_64+0x69/0x90
> [   13.875372]  ? do_syscall_64+0x69/0x90
> [   13.875373]  ? do_syscall_64+0x69/0x90
> [   13.875374]  ? do_syscall_64+0x69/0x90
> [   13.875375]  ? syscall_exit_to_user_mode+0x2a/0x50
> [   13.875376]  ? do_syscall_64+0x69/0x90
> [   13.875377]  ? do_syscall_64+0x69/0x90
> [   13.875378]  ? do_syscall_64+0x69/0x90
> [   13.875379]  ? sysvec_call_function+0x4e/0xb0
> [   13.875381]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>=20
> When a DIMM slot is empty, the read value of mtr can be 0xffffffff, there=
fore

Looked like a buggy BIOS/hw that didn't set the mtr register.

1. Did you print the mtr register whose value was 0xffffffff?
2. Can you take a dmesg log with kernel "CONFIG_EDAC_DEBUG=3Dy" enabled?
3. What was the CPU? Please take the output of "lscpu".=20
4. Did you verify your patch that the issue was fixed on your systems?

Thanks!
-Qiuxu

> the wrong "ranks" value creates shift-out-of-bounds error. The same issue
> can be found on NVDIMM too.
>=20
> So only consider DIMM/NVDIMM is present when the value of
> mtr/mcddrtcfg is not ~0.
> ...
