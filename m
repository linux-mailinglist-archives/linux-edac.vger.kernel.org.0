Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0FC37485E
	for <lists+linux-edac@lfdr.de>; Wed,  5 May 2021 21:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbhEETDP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 May 2021 15:03:15 -0400
Received: from mail-bn8nam12on2126.outbound.protection.outlook.com ([40.107.237.126]:7763
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234093AbhEETDP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 5 May 2021 15:03:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IidfVeOJNWSY+rp1rNHrqrnvgWxRNgvEMT4u1hGa5D2cxQqHZMFpqzcc8pg7pPauCo7K/CcgRaAgxZpQCHJUn9dziML75YyngHTI2b4qhkUio0QB8p7ToV6eqPq+Liwj7AQQYZMFKp4pw8hD98ZNbdyZmUhLMHV0nhfzz+SOKWDMi7GLMQhhtkTDsDhDEJpMO/b6MXQRg065/MWeZjtaqiN2iYGInekS71XipGrKWha9A4EMouZnQ2KwivR5m3wL68zaOlv7/kkboHcg7i9UgpnncgCfmNiX2wqNRrL7PJ6QHiPTE8QPhK1sGcZ4KifTfNLhb5MgmAxvGHpMTLXXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5N6OxhrfX6D5D567YDo7fM1NEoJZ/qYToNeWO5qBMmE=;
 b=DQYmoxecE8lfa0qpdO+Q4nZJo0icRy1y3eST7+7XvIKyslHgtIihL8SJwloDR60bOtharwNmC8IlNED+94e930xO6GL7YIEgvSmHUDTrCkaeGEUCWwhHA+vYBslCp6sSWjW3k9V9u8tBbh1yiZw14xO2ekdh/Bc41XZhvcHF11X34TzqxiAp2m2Dch9iRWOXtAnZevl39NusWxXzbAo9OXPduFXH0qXH4Ow2ZO2qjZxXhesFfeV1vPUAbdT5oxn+tAfT34np770Db4qMOMDk2iOfXlxP+1BThkOwx2tnAouGcsNCIiqqlnm9j9clVxZ6mw2ZijBgV4lINwhJ+rswew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5N6OxhrfX6D5D567YDo7fM1NEoJZ/qYToNeWO5qBMmE=;
 b=BJMJB7keqzPsmQ9Rqgl2ukkxuSWLgL58JLdfJAyRVxs/JhnyuF7tk/nCBYmQHDwY1VoiyBEZTeSz0h2ki346w2ZhBPohciFEp5XTJHo0Tpi7BAHqP6TrZk4J+vdQGWQBQupVXCCuXdHDXR0o+Nw9MEAuHKw3IXSWhx9Quk398Jk=
Received: from SJ0PR21MB1999.namprd21.prod.outlook.com (2603:10b6:a03:299::8)
 by BYAPR21MB1238.namprd21.prod.outlook.com (2603:10b6:a03:107::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.8; Wed, 5 May
 2021 19:02:14 +0000
Received: from SJ0PR21MB1999.namprd21.prod.outlook.com
 ([fe80::c4b1:6e8a:1ce0:c299]) by SJ0PR21MB1999.namprd21.prod.outlook.com
 ([fe80::c4b1:6e8a:1ce0:c299%6]) with mapi id 15.20.4129.012; Wed, 5 May 2021
 19:02:14 +0000
From:   "Lei Wang (DPLAT)" <Wang.Lei@microsoft.com>
To:     Borislav Petkov <bp@alien8.de>, wangglei <wangglei@gmail.com>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hang Li <hangl@microsoft.com>,
        "tyhicks@linux.microsoft.com" <tyhicks@linux.microsoft.com>,
        Brandon Waller <bwaller@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH] EDAC: update edac printk wrappers to use
 printk_ratelimited.
Thread-Topic: [EXTERNAL] Re: [PATCH] EDAC: update edac printk wrappers to use
 printk_ratelimited.
Thread-Index: AQHXQdihEGSIT6R2/UauypUv576OoarVN7og
Date:   Wed, 5 May 2021 19:02:14 +0000
Message-ID: <SJ0PR21MB199984A8B47FBEECEC5D11CE90599@SJ0PR21MB1999.namprd21.prod.outlook.com>
References: <20210505173027.78428-1-wangglei@gmail.com>
 <YJLdZCcsgWG6TrKz@zn.tnic>
In-Reply-To: <YJLdZCcsgWG6TrKz@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7543d415-98c4-475f-92b9-9bd174222ce5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-05-05T18:37:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [76.104.247.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 728ec732-6654-4ab2-d4a2-08d90ff84b7c
x-ms-traffictypediagnostic: BYAPR21MB1238:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB12387387390B01FE99D93A3390599@BYAPR21MB1238.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/kiDu2JcyuSWV1QfaIbk8EsPOLAygo9Ar40S8jE6eHght6Oqo2/wfJ9K+tU7l0Q7m/WdKkz6vNh9Yww5V14J4Jgg0zgk7DppyLFSR6Ivx+68BmIMqtuRJ0cjCPs48evPjqu3fl/EXHKmQNN6R+PWzbrZ50Gu/8gqxd2EyTQZL/qS6Gxm/IotQaOBxFyzaSx06WSlOTPEDmTGQWNXqvoW9dP12AMS6RgPuWpPtWEL4ntJzA9ahlCdfZyWmcHI2frdrC7vxbCwBkX7i7xiFf/4j6YW7H0jmdj5ZtyQA41ylYmZiN/OVCF1YCBKGLIdwbvFO2uZjHzY8VaKC/rWDDGTmi2DNTEkn+2v2Le6FazWlBQHNTazU2lrT6v8mpctz2NE5VZNwWC76yePiym70nNGVRIGn8bHKfzPyG/ubGYSDs1/QyrxMElzJ8JlGZRZXPx0/UA6Zw8x0aCSVeU8smQnB2WyO9Y9USsSm4ORpxl9UeIR3M/Ns0K/qk2QQVfBOjT70hsbW6Xc3ZqVe6GkKIYrbr4F8V8bGVEqyqKRVD+R8u7iwO/BIMiXx35RZgUD8fMfdCkmxWO1d9qXwnjeiU1pg5sqe2LzwXtiDuYhLCfrIIfDWWk1wGHcYLMamuNGitIWxu/zJ4f9W/e0XPbMjgaTEJeThIKd9WfoPScdAu8oWbd0fzll8wX1aoTgXWvK4Lp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR21MB1999.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(66476007)(8990500004)(186003)(26005)(83380400001)(82960400001)(86362001)(966005)(122000001)(82950400001)(10290500003)(33656002)(316002)(5660300002)(7696005)(52536014)(110136005)(107886003)(55016002)(9686003)(15650500001)(66946007)(6506007)(8676002)(478600001)(53546011)(54906003)(8936002)(4326008)(38100700002)(71200400001)(76116006)(66446008)(64756008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YbprW7G5k8A0sfD9Sz3jP49dJdobO5+TlDUtUpE/Fmzznnq9VjFyRkNBKcNJ?=
 =?us-ascii?Q?b0yKLEyiTZ5dHl8zDUa70ztg+64/ftYFLr4DlifNJyimcTeMjEPwZ5qEYKVx?=
 =?us-ascii?Q?nMRT/0YvbAuBkfl5+gljAUJqEcQfYh3BxL79x0uExyj1lYkRQh2koD/nHsfC?=
 =?us-ascii?Q?5YlRbVTPFX9GUMh46LNOTRXvbi3BbFkeS4plaxl7xw65O7+TWC2khIPvZmjA?=
 =?us-ascii?Q?mGXasfNCu2ifRcSfLfKxT6+SGCRSMXMMh/y5Pc2lywSTQ1sve5e2poRTNAn0?=
 =?us-ascii?Q?d/v/cbDSd/QXdWLJ79qq/OoFFXFdekoU49LAOF47GalV6VwU+OZmt3UiHpcx?=
 =?us-ascii?Q?X+cjX7/4YXrpSuHXSvWYgYRhBVzUhpoOWwNbk5rUdVfgjaDu5zePTxL795Aj?=
 =?us-ascii?Q?XtBD50chzzLgemcF1XLevmqDMbLPvRHOeMUDwtyBeVsVpPMWkostphaKTYcj?=
 =?us-ascii?Q?z/q5Aiv077prxjpAt3L0sdacIIZBuNKEUX6zgLKjURtD0XXqIAE/TWH6cO7N?=
 =?us-ascii?Q?l9lv1kKCrlgevc0ra4OzIDI/Zu9nxWTlSEkyE+v8xw4Y5qF/l0J3SO/TiqhI?=
 =?us-ascii?Q?Q8fDd0UPnKFODSu0Mk3KO3nAC1aSOSLRGGqZ/y09wQwNGZBmx6Jd1aMQfXGh?=
 =?us-ascii?Q?TDPT01hnALSpQ52y0GrEcbiH4nhHp0IIptifmm2aV3rXq36NZqVI3FGsv/Tn?=
 =?us-ascii?Q?QqA3Y4AyJ6dRqwnEwUcwTtWZ0cAWZaq+qi4IpIfCufgAaEb8c62aO2riH+RL?=
 =?us-ascii?Q?/3nw1ir3BafkvplOr3jsAW4fRhc6p/3zfSGChGgcfkPZwp9niWH3rhg2bqwx?=
 =?us-ascii?Q?vLuEgVTv1W4f8cqr0+ML9Ke0b3/ic/1xxXOWewOT457mqWyZZCZ2LQfahH6A?=
 =?us-ascii?Q?uBooQPUBfhLNnCH/BwYPPyN7j6rKXRCWFjd77attZqM4o8tStG723+h+7KK9?=
 =?us-ascii?Q?c1JRXzF18+grXoorShzuBPlh2DkOxIUQXZhwWtaf?=
x-ms-exchange-antispam-messagedata-1: kVG60KG+cMhvq8TWTcjZNWlYbx3SEDlzeHN95bJ5j7bRbECtf+7T8SLo3Nj7u4c8aXWJGbcSBJjkhE6woCN5TivD8vdCkGSjgLYGThP4i4x184Mph9ACDaYrXWrBztWyb3unMnetzcXj1kzkWSPG0AOlEtjH+sA1qccwpKMlLy1LGaEpt5FA9+N3euJvXUkoc3sSqhfYDKt3qBEJK7lB3xk2HrXfEAfO6PeSgShHjfK14578A0iwOjQXGRirJPV56g8z87FpP8ARb+iAH31O7gvptN47Gy3egDqevRtUFwVDwqE0fOt7v46A3op7ZgWEGsWm6glU2Galme6kGnxyDbkM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR21MB1999.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728ec732-6654-4ab2-d4a2-08d90ff84b7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2021 19:02:14.1348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PgHsH0DC2hEC4L0QuekaENfbo9adnSwvee1XnQ92OyDcsUvYgvoxiCV1SzM73H95w7s0fDt9Ch0hRo+kassWwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1238
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

We found a corner case in production environment that there are ~500 CE err=
ors per second. The SoC otherwise functions just fine. Making printk rateli=
mited reduced CE error logging to < 20 per second. Though this is just one =
case so far, we think moving to printk_ratelimited could benefit broader us=
e as well, by helping control the amount of kernel logging. In most running=
 condition, the error rate is way below the limit. And in an error case lik=
e this one, vast error logging would not provide much valuable details, rat=
her it's storming the kernel logging.

Thanks,
-Lei

-----Original Message-----
From: Borislav Petkov <bp@alien8.de>=20
Sent: Wednesday, May 5, 2021 11:01 AM
To: wangglei <wangglei@gmail.com>
Cc: mchehab@kernel.org; tony.luck@intel.com; james.morse@arm.com; rric@kern=
el.org; linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; Lei Wang =
(DPLAT) <Wang.Lei@microsoft.com>; Hang Li <hangl@microsoft.com>; tyhicks@li=
nux.microsoft.com; Brandon Waller <bwaller@microsoft.com>
Subject: [EXTERNAL] Re: [PATCH] EDAC: update edac printk wrappers to use pr=
intk_ratelimited.

On Wed, May 05, 2021 at 10:30:27AM -0700, Lei Wang wrote:
> Update printk to the ratelimited version, so that in some corner cases=20
> when vast of CE errors show up, the kernel logging can be suppressed.

Err, why?

--
Regards/Gruss,
    Boris.

https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeople.=
kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=3D04%7C01%7CWang.Lei%40=
microsoft.com%7C71421584bc2a43951df908d90fefc1b9%7C72f988bf86f141af91ab2d7c=
d011db47%7C1%7C0%7C637558344708605379%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DfJ=
G0%2Fdk8VCVNIGS0kM2BZDHAXLVcq4CLHEajhND0rzg%3D&amp;reserved=3D0
