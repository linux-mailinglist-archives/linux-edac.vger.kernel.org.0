Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB7C409BFE
	for <lists+linux-edac@lfdr.de>; Mon, 13 Sep 2021 20:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240439AbhIMSVS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Sep 2021 14:21:18 -0400
Received: from mail-co1nam11on2049.outbound.protection.outlook.com ([40.107.220.49]:18319
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232400AbhIMSVR (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 13 Sep 2021 14:21:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFTc3RGBH4BvuAug4/t+SsyDM3/VLVKGoAUZCBwSMPxmepmqmz4MAiAc9ePNYGGFOF8hYrnbDQ432K1kli+xUJz/uGeRglQ8rW1j+UXkLg0Yh25b/R6hLked5mEkKvM1P1+Yk1OHizd5bPTN/OZg1qTDb9V8b4/a4kxD445pvlq1b7Erajx/qc98fwaE85uRFb6k5qHcfEyACar8TmbZUqm04IZkubMmLzZihZHaFVKdykToBXQLgMu9E+OhvwQhD1pf9e6BdmarpB1kjP7Y0QqTss/K6UfJ37rouDrU40PKvMMxlJjIHlBDeAaf5qeF5pExJYMJPAK1VZqWGe+TGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MViiSK2iGSgCzj+8GpARMN6cxEruwYQ/yuYXLd1YMEs=;
 b=GTuBrt2HSi6DjgO2jzv5FVJUyjsCw/YNMralXoNsTB00QcLyecSqk3Suh8bInxsInnnpL+TT6UtVX+Ga3r6+aThHBJqHTjogB0D0wD2M4tGSjTSFyCgcd2PvLTdlDQDr6ER0zfIoX3r8FGjMCh6AVfqfjPrxPaeBbQH2aN5e4m6lNQS0ddpkSJr8tPBRG0OzR6nl2WJ7owFNIIDDvPaUf7EVeUcECTZaHOI7tqMa2YUI822nh4k2FNwZ6eUa7nioRUgr9tA1rqDSpcYLfTXDOtGkgn8SSLlL2s7Ae3KwGN6hOwRujhpX/cy42Ce+VlVH++Y/5hJfp7daiiETYvj74g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MViiSK2iGSgCzj+8GpARMN6cxEruwYQ/yuYXLd1YMEs=;
 b=AHvD8+VqkLwyT4PcwKqhdjAmlSDKFLmxBaEp9gVuxF5xRxkKBGRv0aC11zcck13TRo6sTjT08RDhSHWJvUEsbsr4WjiBMN5QcNQnZTd/swhjFBNXHg+usTkZJ1o9CTwxfJGJIYyXpHlnhCPSYICAmCdA0V4Kga0K9SzC0+96PG0=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3539.namprd12.prod.outlook.com (2603:10b6:408:9d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Mon, 13 Sep
 2021 18:20:00 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::fd41:979d:a3e1:d958]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::fd41:979d:a3e1:d958%4]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 18:20:00 +0000
Date:   Mon, 13 Sep 2021 18:19:51 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Naveen Krishna Chatradhi <nchatrad@amd.com>,
        linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v3 3/3] EDAC/amd64: Enumerate memory on noncpu nodes
Message-ID: <YT+WRx9Y2W+GRymJ@yaz-ubuntu>
References: <20210806074350.114614-4-nchatrad@amd.com>
 <20210823185437.94417-1-nchatrad@amd.com>
 <20210823185437.94417-4-nchatrad@amd.com>
 <YSjM8b9vvkmRew94@zn.tnic>
 <YS/JkgWA8VreIx1R@yaz-ubuntu>
 <YTkD6iy9JhwetSYU@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTkD6iy9JhwetSYU@zn.tnic>
X-ClientProxiedBy: BN6PR17CA0023.namprd17.prod.outlook.com
 (2603:10b6:404:65::33) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
Received: from yaz-ubuntu (165.204.25.250) by BN6PR17CA0023.namprd17.prod.outlook.com (2603:10b6:404:65::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 18:19:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7873005d-243c-4e2a-b7ba-08d976e31907
X-MS-TrafficTypeDiagnostic: BN8PR12MB3539:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB35391CD68504352F9BDCCDB0F8D99@BN8PR12MB3539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oL+5E1UxL1QsD8alhi+9SpU3GQZFPU9fpPRNV8hIjAxNBEESYTRs+un9CfBQzp7qBQ48PN5Swt2jRCRLZQ1hRwXZ9SjPUvugqRuGiGagzKImDIow4mQ94jooqLXjwW/dp3/3/RpnpnPRQToT32ezAqxDZTmRUy77fxdJ2a58rNLmDylPCy4vjjl7JK+PBp669kO3Lbo+jG39K/CT9X+EcwwPq+W0DV8ZsEpV+42ciSNzdDA8QuCmEKHbl7X0mb3LQtdpbXWZf87pBm4tOWD/FGYwBzqD0H2emeDeRs0oVflYsV++iN25a3wQVKWT451NBEjSyzZmoaBi00/qcNdW1ujfcz1BrcdFafwr5X+BoMgXdBFNGLRLlOu+UjohFFHZG5qOWt3qgbLd6lhik9tqkBCEWjCuZ5aaYNc9vL2PhjKiOoJJrRTDDmysB+a22tuDtfoOkxDYKbkmhIXmE+oK9a/wnUcCzhIeMSYSPBSC49k3LDuNMGiN8ShcDJyUqFNjqvmvWL6Jjyxh+d5Q84OXyjbtPTdwiBTOPvzI8b1tFG3//ivJK/xgsZwno85+v4sJCPsV2+7xA0vXrYEmBf+OWv6UkIxEMGIOiYzPmOka7z1d+DIErpNjqFKw1uJSGbuSqR358/f+rUnmW1zX7kxsQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(66946007)(54906003)(6916009)(66476007)(66556008)(38100700002)(9686003)(8936002)(55016002)(478600001)(44832011)(86362001)(8676002)(26005)(33716001)(2906002)(6496006)(956004)(316002)(6666004)(186003)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6QG/u8rHSIxv2Fbn38FoPqKv1o50EydOJ0crY3hiC+w4oabwMiWYgMrwTzkc?=
 =?us-ascii?Q?T9MXUJAvAXABHhBBMZNdHbmeoUmmbVB3S4ee6LTiprWLn+UuXQLCGOFN6ZKc?=
 =?us-ascii?Q?pe2xPUSXQfYoWuojyMKnxHm+o0qoetQHQqggio+zZbNUokz7nS52eidfcVWU?=
 =?us-ascii?Q?welgHMABLqloMsMCpzxou5xsz34reJnSOtK9jw6CH69MXihs2JhGloxrUXwF?=
 =?us-ascii?Q?a/15yxeDgWBpTr0USHv4FlHIMpWVImnDsxXhB7/0wHoMiunqRltka/Amf0RV?=
 =?us-ascii?Q?75N7whAzK0F/kzqb6bej59kUDYhgP6/askLN/mmLmeQYTF1hxIa6HEK5lHny?=
 =?us-ascii?Q?lfd6h3xsuMu4wHX05KLEopIsm/f6dw92UbcHmn1dVF4c3wBTSpowt+XDd+qp?=
 =?us-ascii?Q?Tmxksn7uiBXwk4IYwtWQdOwFWAFQID0QNf47GiQddxWX5nKiHuZJt12eI4uJ?=
 =?us-ascii?Q?kvgYVgkC5NRT4HDconQsf4VD7O1l0AnI4uqgPtwD3S0bvc/8t9mqqedPPFkr?=
 =?us-ascii?Q?slLjQOITr8mF0MVRS2iMi6rMqQhtuiTlGnyKq+IIy0b3wA3K43bQsDicboEJ?=
 =?us-ascii?Q?M+9C2CV8HR2wk469l/rVKAO/HbMR8Cp6VWqmbcGRObR4rFEkYPj00IaGNRb3?=
 =?us-ascii?Q?bH3YY/9dSSgoXCgoKOGFQ1OWHnCPpYOugIgVHtEgraXzJnr6WDoZ5Pw0hh+R?=
 =?us-ascii?Q?Ey9i2Vpli+mo6CTuRw7UrOfXYjiypI09fVkCwPOS4tNRztTCBhAxp5VkzFqN?=
 =?us-ascii?Q?EJfLIlCM3kexxlxHQ3nDrJPNY6QNA3v808N57fltHFb2+E7oRte82Z+nqQ17?=
 =?us-ascii?Q?ig8f61lJgK/0vHGguh19OShNOKWtvfDntAY1G7su4z5/6BUZCFzXsLfNWVGU?=
 =?us-ascii?Q?m5V/8q3I1sbswM8gue5AMB5tK8ZgFyT7GlOCKEz0/aHgJCdXsvW/DrpaErWc?=
 =?us-ascii?Q?azU3biD2LdoFhWQMeX3osfOXuk5dMn19iBQcBU01+W2qLngjuVpxNP4Ka+Ff?=
 =?us-ascii?Q?tY2TqjpVpkRbK9ZQqBwBoA9lJ5+Pem7zibnryzd94x1h+ihqE+M3kE6kmYbO?=
 =?us-ascii?Q?mqe25ldo9QZvhaaajm5zZwZDbBwz04GfHSW4X4bsMFU4cNPze4ufSj4we+qV?=
 =?us-ascii?Q?Oza7BRqo/U8IyG7svGyZFacUUo2p8kLNMfQiacJ7CRL9jzHgW1vKUy1q4O9U?=
 =?us-ascii?Q?FrNA8oifIeRR4sxLvpKIyGfjh4C++7V9YTjQsq4rK1/V2+sqN4BIeV3rn9nx?=
 =?us-ascii?Q?nz/aZ5UCVO7wTTFafWGonRqeJ04c69z6gXScxqF4Jo/2y7SVdghXiRzEIyw8?=
 =?us-ascii?Q?UGLNhxYh6chrscVVPw2ZVrFe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7873005d-243c-4e2a-b7ba-08d976e31907
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 18:20:00.0814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gz+r0q4TolY5xM8t9E088ZC4vcoFGld3FAMYqrGfDLwPoMojXulxTEH+TU+2sEdYkcfYz+PVK/kB0vxAWplVYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3539
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 08, 2021 at 08:41:46PM +0200, Borislav Petkov wrote:
> On Wed, Sep 01, 2021 at 06:42:26PM +0000, Yazen Ghannam wrote:
> > err.channel still needs to be used in error_address_to_page_and_offset()
> > below.
> 
> I think you mean __log_ecc_error().
>

Yep, you're right.
 
> > This is a good idea. But we have a global *fam_type, so this should be moved
> > into struct amd64_pvt, if possible. Then each node can have its own fam_type.
> 
> per_family_init() does assign stuff to pvt members so yes, we're saying
> the same thing, practically.
> 
> > Fair point. I like the idea of having unique names though. Is this possible
> > with the current EDAC framework? Or is it not worth it?
> 
> We don't have unique names for the CPU nodes:
> 
> [   25.637486] EDAC MC0: Giving out device to module amd64_edac controller F17h_M30h: DEV 0000:00:18.3 (INTERRUPT)
> [   25.799554] EDAC MC1: Giving out device to module amd64_edac controller F17h_M30h: DEV 0000:00:19.3 (INTERRUPT)
> 
> why does it matter to have unique names for the accelerators?
> 
> If you wanna differentiate them, you can dump the PCI devs like above.
> 
> Just to make it clear - I'm not against it per-se - I'd just need a
> stronger justification for doing this than just "I like the idea".
>

There isn't a strong reason at the moment. I think it may be one less hurdle
for users to go through when identifying a device. But, as you said, there are
other ways to differentiate devices.

Thanks,
Yazen 
