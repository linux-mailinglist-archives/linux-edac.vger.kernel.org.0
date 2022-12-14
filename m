Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD64A64D1CD
	for <lists+linux-edac@lfdr.de>; Wed, 14 Dec 2022 22:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLNVaF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Dec 2022 16:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLNVaE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 14 Dec 2022 16:30:04 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2B536D77;
        Wed, 14 Dec 2022 13:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671053403; x=1702589403;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+UzQAQcBNL5YTRi8o3kEJq/5Zb1DTR5GTUfMPfnMsIo=;
  b=jWZKsbZfEczzXr0RgVEojIC0e5nFqd2ycfvAr2xtXbo9lgdE+YgbUyTE
   toyK1CAzPbSPxRaiUbZterJDplVwdDPjx6Uq1dcXYc9c29xFUP5rbmvGc
   l7pofaPGnI+6okNuoqbbNQ92yTKF6lc5RtQfhWZYXURPhAtxhqeqGsrxf
   /hzRBEwkI7pPZWhJyaCGtND6ytNZq7GGfKHQCxClRHJOX8NToBJ4k3tnf
   r3rQlamRs3h5UQK8PorHWtUGKW3fc2RGaNgC/Z7W0ay4FgQxXbrFr6IUx
   AfIRzEHnjHTI7nU7CWMmMNE7B00pfxDGN5b0cktyTvBc1RRGGjz1nVM2p
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="320373879"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="320373879"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 13:30:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="894475326"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="894475326"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 14 Dec 2022 13:30:02 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 14 Dec 2022 13:30:02 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 14 Dec 2022 13:30:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 14 Dec 2022 13:30:01 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 14 Dec 2022 13:30:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIjiQm10d9U63K3q/0ZBc3oBTFANnmdmS9qL27HChmNM/jfVOcxSq7JIs3m2s7Nv9zDLs9rwaaj8+pfwmfJ6iDpvSW8b2JDY52ixKScqkWVcQ3qIFE1WqBc6E6RV7GioXlKCMsnGHdL7AB/hHKMR/0t/2gZfgp3KjIExfV47sO9eD2cqB/uJSqh09T2oIHdZSfULJ4dZHFy82HkDhbiH18SHjKOlgJBq5eOdH8eJ+hzGxTIe6Md7WOmOTGm84s2OnUq7y5zVtD+ggOyAeiI2kKFWXwxsj0JB3QEyjseRAWM59pmjzyWM+jHW6c/Zrch210KZ1Jf9KvF7VjH90IArKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35CnUL154//N9xj3HKQoujCDxm9ZAI4wEkEUWR4RvjQ=;
 b=e+6mOSI9LjTv+wxKX06VxTATVOlrxW4mfLiPRQk8ZdnC4bfA9x7LKfntO48lflw7W10uaQgK6gDbYt5mww6tXsBhVHevOzMqvcQ5e7s94VxoGV1Oauw3dIC0aerw4nopM7erl4o+PtZM4WjOZOEUneYKmtdtAv2mVr9j9ofS0AdhkT+uvHvvzyRRc+1z8ZHvojhk/6wruTqFVLFQqviTmBUfcz5nQZMGf3O9s3DTL0Reyo9sYLS25zF2W+37DGVf53p0FanLjR6SUwnmeJq2KDFzgV2z0CqSXfSyhjB8Z2TzV69wON/MPfMvPyYIheNajB/EO+8AUKU6Tc7iN7yI4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB6309.namprd11.prod.outlook.com (2603:10b6:8:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 21:29:59 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%2]) with mapi id 15.20.5924.011; Wed, 14 Dec 2022
 21:29:59 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "yang.yang29@zte.com.cn" <yang.yang29@zte.com.cn>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xu.panda@zte.com.cn" <xu.panda@zte.com.cn>
Subject: RE: [PATCH linux-next] x86/mce/dev-mcelog: use strscpy() to instead
 of strncpy()
Thread-Topic: [PATCH linux-next] x86/mce/dev-mcelog: use strscpy() to instead
 of strncpy()
Thread-Index: AQHZBt9A71m24QU0eE+uWk8CipUvUa5t7tAAgAAHq1A=
Date:   Wed, 14 Dec 2022 21:29:59 +0000
Message-ID: <SJ1PR11MB60831C20F1A68163E04D742CFCE09@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <202212031419324523731@zte.com.cn>
 <20221214205438.GB15255@ranerica-svr.sc.intel.com>
In-Reply-To: <20221214205438.GB15255@ranerica-svr.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB6309:EE_
x-ms-office365-filtering-correlation-id: bc7cabf2-c841-4d1a-fa02-08dade1a5a79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4KJafSGm3/EoeJ46Ylp/1hjgJPnuYe5AJ5Gzm69nEj4Kpfq6F0KwwU4T231EI+YydNm6RPT7xdKa79Dqjn7L/yD56kslWKF3TAmCJD5mxIUswTC7BsVkuDwmFoxuYLRC7reDazKL2PyA+PljISMW02VqTR0LL8X5Orzkp4hkFFz+xq72nKdp33QaZYX4Nw8ZofAo0rsClEGXxKtBWk3IkyIBPZ3M12RLr8A769ZtkvDjUXDGORNwYiEiItMPF1sWz2A57Jx/Z2nKaQRt8NaYBvgcylFxuAiGNBVfh6Jhuxv8ztWFCCFtiPFovvky4MiFoUbLET8as7Y9gmAFi78y/LPq+f4ojA8UQExTcp05Xj8o5y5jxd91FhnXSBUA+AIlvE2q4V3dyFGA9Ybtsvy2nVpy/QZVHfu5byImf+Ybvus6Sghbh3cjoIJx6GLlJ1eWx51DtHuo2iy9HfsrYU8uBFkzUSAYYXj9pLzcfM+90kFZI/WJj8kPxrBYo9EhnrkIN2ytcAlBDwDNFfXj1TuR/sfNLgr6ukkTfvUw43aUz0+sFnMzjoUYVRXZKH34XXcyuUm8yxjdQ/rXeSqEN6Q2xhOWS2a5asQ13ZvR72QiPVpE9LWytmPGZT2hS8LuRYWtK5w35xNAG9PxXCIsXPH4AHS2DfVPRgS3/YAlRPttemGfuzEx1bDv6uM0no4bGIJh1cNa0YXA8Wp5uTYzc/jpsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199015)(71200400001)(54906003)(316002)(2906002)(478600001)(7696005)(9686003)(33656002)(110136005)(83380400001)(38100700002)(122000001)(82960400001)(86362001)(55016003)(186003)(38070700005)(26005)(6506007)(8936002)(41300700001)(4326008)(5660300002)(52536014)(66556008)(66946007)(66446008)(76116006)(64756008)(66476007)(8676002)(7416002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?EcA7D21LNRC8lFA6KgBRtRnXsxmHMwvLSvOduudTEhiVENqbL7b30Gaadav9dR?=
 =?koi8-r?Q?Epn2AONEwDCVyZEwv2A0JoGtgotDVhemJ/0oncWVx0/2XdbWr1JWBrB62ZppvW?=
 =?koi8-r?Q?+mLwBuXo0pFJxAHmPj4UlRJPW12REWQm4N4hnQVRAeMbY5VMoNyti8FWcOx6TS?=
 =?koi8-r?Q?0VQdwkL631wW8VVMXxdXk0yKK7nv9as8jsMLyup/f2Bh1JTWa9YA0cXqlc7KXo?=
 =?koi8-r?Q?dGQ5jQMvNjTrmxm/2ZUv8nvcemJt03QCljYINWUXozcXoKSaC1NXKQTi3Kpy6G?=
 =?koi8-r?Q?U9oy3W4BtJCOe8kpRyXn347hG076qwYYAq0iN24esw3A2AAQW1Vs7UzO4NLQHC?=
 =?koi8-r?Q?JigMvgxzCPLFirk9WT3qsMAGkcaM5tJpjJiYELLtM4Xga74vRFKO5alNMy2egP?=
 =?koi8-r?Q?EaHOqaBTaU7kf3+K4zDANrUx6na03iA3f6yNTtiPVTzDJbPopeexx3e1m7pepq?=
 =?koi8-r?Q?Jec9eozTzihT5c1mXAd0fZbi1lgkMuHQ7aBBFBJT7LRCwK68VWVCbWm/yKlPC5?=
 =?koi8-r?Q?TESDUVKLXlu3bEnJX9/2yaeRl9sT7ZiOyr1GwPkp6ayYmcIpEbmI7F7wbr55iP?=
 =?koi8-r?Q?+bEzJ+pBdxfrgIojy/N62HP2TEocCJoSL0hKaFykxy3r/rmZXuk0sIYDG+M83T?=
 =?koi8-r?Q?BqRYFTz0rwkUWoo5cqrIpKvzTBEouMVGwZl9cfcRWPI78t3i+CY2ksVVWK3Qaa?=
 =?koi8-r?Q?87EAIF8jsnCDAtqynzty/bWtIk5ZuoIZudi3WlZP54Nx80zNAeLF7LXyd7t9H+?=
 =?koi8-r?Q?434Z+iO8CnyPrQLyF/o6bGoCPzTRsz9secVD1JJsXtPIR1izggy3HisjKjsV+A?=
 =?koi8-r?Q?3nA3KE/jMxnGzgovQfpl8Rxlg0pEKjBl47qCCF2W4C2Af0kZizyxvABgj4Eur+?=
 =?koi8-r?Q?zYzV5LM62ZYkFGxQZ9mgVBp1A3eNX9ZB8U/PaAwLgkUuCWQ7Li7Q3ZcLxUz3/q?=
 =?koi8-r?Q?qwhBUo4ci4zbu0Y9BdtqbYVFjW7UdFrjlJGXHNEuhyGIcqgMXoL7Jp4HrMtdLk?=
 =?koi8-r?Q?6vKWGF5EcEL6Va6sq33NO/g4Tz6XPIwoqaoosWxbFc4W/VMaStZsQMMX/+QgwF?=
 =?koi8-r?Q?RgGL0pC/WxlPrNB2am4EmMJKpV4wZrjVYsiDlFjJhj09d9YrAZB02FS7qDLvsi?=
 =?koi8-r?Q?jm2+cAHWK8fRmND7YYrCgAsTy475oVCvqE++8B1vEnPBVTODE6yvjYtNsov+ME?=
 =?koi8-r?Q?lqRkkIzYAEBlffTvBt55L4b4O1/jD/34U2INaKWAOAkvp7HHvtCz+dyJ0UaxeI?=
 =?koi8-r?Q?PhnQ7coqjYVc/klKrqSji58XUTNyWQNBsYmkjJrVVb4KgKJ0wkcEO18bkWGgvd?=
 =?koi8-r?Q?oCo23lqeZTwfTom+WhJRi1BRue/0KcXxnlwGVpmMpSvrpuH0kzGqvAPoEUytQj?=
 =?koi8-r?Q?cD69tlqTx5hDDwbJp+YJBYUGt1eV28/16a/y1DdMxoLgfVHGo1v4eY1h/ddInV?=
 =?koi8-r?Q?4R+AeKNbubCpkwrdxVsjIl0cruoT+Ma/5hxM47Z/hYPwkm68sUYsQmQ0lVbTL2?=
 =?koi8-r?Q?Ud0VsFax3TuKuHabhMd6owLGP9jtSycSs8zocN1SffW1Ss3D0W?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7cabf2-c841-4d1a-fa02-08dade1a5a79
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 21:29:59.4649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zkw7uwpeOyWWRdPS09zL7xdKZXNRF/MoFZsdITwdco+WqkZ2z3SeWw7eHlmMZkyR6PtF4CNEkFHPe092slj3ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6309
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

>> The implementation of strscpy() is more robust and safer.
>> That's now the recommended way to copy NUL terminated strings.
>
> It should read "NULL-terminated strings".

Both "NUL-terminated" and "NULL-terminated" seem to be used in the kernel
source and commit comments.  NULL is ahead 124:45 in the source, but it
is closer in the commit logs where the ratio is 129:76.

Single "L" NUL seems technically more accurate as the string terminator is
an ascii NUL character. From man 5 ascii the character name is NUL (though
the description says "null" to muddy the waters)

       Oct   Dec   Hex   Char
       =80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=
=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80
       000   0     00    NUL '\0' (null character)

-Tony
