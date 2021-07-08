Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A973C1A08
	for <lists+linux-edac@lfdr.de>; Thu,  8 Jul 2021 21:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhGHTqy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Jul 2021 15:46:54 -0400
Received: from mail-mw2nam12on2086.outbound.protection.outlook.com ([40.107.244.86]:13344
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229497AbhGHTqx (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 8 Jul 2021 15:46:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5qi0bAX0IcCoyD7ExO05uzhp4NCzpRKGnYthx8msiP4fHJ/Wuol8KbseghjxyL5BuEhMphFpqWcJzYCkMSp2MLfF3XolIcomRp3jjMUXt6TDlyum1JW0jBcelKnQlkZgMxDnYNXEbHyXlabyNvhJzFmWy9uCcfXkQK1nfZK/xQCTezXZc1fzgdhBx3KTIZYjO12t8M6Zrr7qhsQl3aEuCE64d17V2lEPFyLnnrh1qYpR1Iat6o7sHalwBsoyzWWwOFGtfOVfWrqn6OUnT3saTr93SiVLXyJ4QtVI/ZlgBTZ6smxqlulNJ8ryRjrwPU8dzZvPW+cszX6YL3vzC+BLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61jR1YgIt3J9TpJklYB1eI/kxsRVUHA4SbNMxT3Tkng=;
 b=ZBLm7rrDbC86zwUd3zMJcW8I4f7dTZr9mQcPADIi2akehORvDvODDEUrdX/brY7eVWC39ladtIzC98e221w2ZPozBP0RcInEqzpDZpVb2/OwiKb5Fb94IErjsXtogMi46zKCHp7JWnmTrA6JSkW9kiyoJOQSPQq2jL9x2QsvKwyK7bJnKbQhJffSLRrUEXKRyABpCKSH7EWbqA5sc6r8/sLzkwXv6u+vsghX3myfXMWCEURMrXnmatzeTmEmEEOvYKyJgcTg/wwHkOI93w8yIvXr9wXMiE7g1t8/FMrocKlsMr1QgBGE/bxKy1l1R52uzSXmkwUTW6uo5a58o5TPoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61jR1YgIt3J9TpJklYB1eI/kxsRVUHA4SbNMxT3Tkng=;
 b=31XQl5+M03oBI5UuioZ92AuHN9jfI0Q6O3aF5rj4lguKKQdH5+CNYXHAfVVBqF4k5vk8dO03s4KXr8lfMHPgSUiG2LXHUL9YdvL/eIWa24gqWw4ekgTLIlo4PzS+NgHLaydTHO+958hWsoySm//gf43MPPtOS3gZwi5xRXfplIo=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1185.namprd12.prod.outlook.com (2603:10b6:404:1e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Thu, 8 Jul
 2021 19:44:10 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4287.035; Thu, 8 Jul 2021
 19:44:10 +0000
Date:   Thu, 8 Jul 2021 15:44:08 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 04/31] EDAC/amd64: Allow for DF Indirect Broadcast
 reads
Message-ID: <20210708194408.GB15605@aus-x-yghannam.amd.com>
References: <20210623192002.3671647-1-yazen.ghannam@amd.com>
 <20210623192002.3671647-5-yazen.ghannam@amd.com>
 <YNyaXr9yfi/paLt/@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNyaXr9yfi/paLt/@zn.tnic>
X-ClientProxiedBy: BN8PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:408:94::26) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN8PR03CA0013.namprd03.prod.outlook.com (2603:10b6:408:94::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Thu, 8 Jul 2021 19:44:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d22f933e-1078-4ddf-1b32-08d94248c14f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1185:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1185D36A9649907F60D799FBF8199@BN6PR12MB1185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JsBw1ZFcN3h6B/Uc5SdoDff0pe55Szj4CJZEckrCTxnyht7vnRA8O+c//rOr9VZDJ4hB8OE7S802PE7pjHRApeXQUWThTpmfLIDqfA5S2sy02JD+Lkoh0SHHt7hhOJm2PTSY+TGDqDvJJs4vE6yyFNEbF3vKd22V74LP+ZmTEwBCjv75gtTASizqSp3GyuM5Ne0xqV5eFxEMfYAs+ZdaRgi54HeuplasjUexOIUobKk3wl/g92087137/R5icdlt1m7iObSz3Ro8sxH2eBmPgVtmteHeS4hKfgzoirT9y3YVG6K7UZFDaRiRIjbmE9K9rB1H+EFkbPmuwI4xQKgfsg+iH9vIzbW+NUj6oREBsYnyVHfl18PI8wzOR0WqK95llvhB77/59kptpK3/5VYOBqd/Y1RfRyH8FwHiWJ8cnKCC8L8cAxiBDhyD4GgCR7mfqj82MatcsfH0x3SsbGpmMt2t4/0ROsTT+ZgpjcArqPsOY/C5kct0ARd+avRay3CnqDJR/E2bjfkphQIz8w//w94bTebRkot2xjtrXb0H3JMAMGflG3VkcyDtcBQ4Cx2AJOlBE6f+lhXJoAwdt+cX2ky5aQyxkJQ0UOpJMt3H/CN8losr/lLmnveu/GgtAx+3XOwoDDisawPglJ8VcuV6tLyVLjxGgrzpUPMeVAcI49IKNH9sT5tEyidfbvqyW24AW7+OLXKaiwfq1ZYljL+6JBBH9Eizw5f2tnmIWVJZGEdD7rS/qY45Off2xO/BipZZxwfWD9rqRUPXlAIdfwnzjzgcnSL3yDq8WBmHevXEuvQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(1076003)(186003)(6916009)(26005)(66476007)(66556008)(38350700002)(8676002)(478600001)(38100700002)(83380400001)(66946007)(8936002)(966005)(86362001)(316002)(45080400002)(52116002)(7696005)(33656002)(5660300002)(44832011)(2906002)(4326008)(55016002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I1sZmUrGuwXSgO/IU9l5IklcA3Q1MgcsRnuQNTBLXsHfxDaH9QVfkNrpxsfc?=
 =?us-ascii?Q?PVwYaaTUF+8iXaZ6izJIm+5qPfHyCqRcLAbhv2eDq1kkBc/g76N6OOWdysTB?=
 =?us-ascii?Q?xiFYV6glx6/zwaXfjeeJh6ZLYLF5aV8as1ahGf8+bTwI9SHSMR1d8Nq8iSg8?=
 =?us-ascii?Q?v999eNmgY8jtFwpHDZoU+I8bg8/O/VfMCjWr1Ge6HAZdb+JiPWdfwhFAZWnp?=
 =?us-ascii?Q?XNPKMLNzj9Di9WY9QwUQPUFnYeDBYnbvrcrJIGj7tJi9bS8LObzy/D9WGQjG?=
 =?us-ascii?Q?xuexhbMWw4OY09n3IFTWrekyRJYmD94JFLv/9xiB8R4VTfDVkKjU8lOQ8pYj?=
 =?us-ascii?Q?ZjLsrHphLQndb+GQynNF0Y4OOAdjptY7dzXQF6ikohTjYkhb58X2mbkI5OOz?=
 =?us-ascii?Q?BS3ckQA3ttfra+HFo1DBlIzVJybyiKMq27VFfE3zg/LSIcpFqfBz6dSh0xvF?=
 =?us-ascii?Q?1TgpGGPONe02PxeQ6jt0LdclD+wyvXyOOxsDXSagHMZl3XFGBN/DNR64bkUW?=
 =?us-ascii?Q?XaavEv0dMHD5gaLLDPk7B5G0XC0F0ZhhaNrQJmoQUdBKzS08V6mK+ZVnarBI?=
 =?us-ascii?Q?4qzdCMzEMgc2hF2MfQY4lg1pspexe/1QQTsdoTsXpNRyozdXIqgXBEsS38uF?=
 =?us-ascii?Q?WGUhkGDg4yIBNaWjgPWxW/HAMWKMsQJOS5YZu6FoI0bHelC8qhyEjDJmRioX?=
 =?us-ascii?Q?UPd8+5RwjH/topl7Ee+H9dPwFeA/Dii6kpL2RfikivlgakWMGnw3loYVPoiq?=
 =?us-ascii?Q?cHcLuzG5VOJFMJrM4M2SmE9xKsy91g2DNx6j4didyJQtmkgEqnJVRmkb4tql?=
 =?us-ascii?Q?yl6eYJ3ESMv6lXw/Nr7Ce8kjXmfgqOd4yqSBd41W4ov4jlLl9fuOUpbaLD1X?=
 =?us-ascii?Q?KMUVI2nQZW1n5Ay3ex/XbyPKAA/7zkEohs/CyAVmUdcxPdq2fvAQkx8EY1lD?=
 =?us-ascii?Q?9IIUQ7zh3JqAAMXnMsEnDjoJNd7ytcQS0vT0ABGK+E5IZC+QkAekz3ATUdGa?=
 =?us-ascii?Q?QO/QwR7IsrOneDlUiW0m5pGDtWzY2MBiOJtBzUf9S0l+DZlwZ/WY9oO2tWf9?=
 =?us-ascii?Q?TpvVpGvq2gsvzALmS02ZO6urdrgPxDDTMNktmxmSNL/xFb2S12QMD4ACh3vY?=
 =?us-ascii?Q?9qEXAgvNiFG+M89IqPwidB040GMnJ91EA4Jw0JoIrT7s3ATi3fMCg/Qp/+cN?=
 =?us-ascii?Q?Ewfw0xKCGe/NJCyCgbfhxa3ffBkvYSmpkk2dF2KF7/xumFOeksJF6FlTCwlT?=
 =?us-ascii?Q?rCaWC3cQpBBev7rG0hQzesH7ZmT3AvExLr9u/NOj5gZyd+W4LFy42TRVuAqB?=
 =?us-ascii?Q?1Y+BK6gIy+9SmW19sKSMG9Rf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22f933e-1078-4ddf-1b32-08d94248c14f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 19:44:10.0170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNhJ2tQ0k6TNGYwqzC/YOoDjfcl9HqooOILZq8CmouHzhzSLk3Gnk4mK/XStWk5EnCVGFuCYNwUq6ETcP6Yzhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1185
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 30, 2021 at 06:22:54PM +0200, Borislav Petkov wrote:
> On Wed, Jun 23, 2021 at 07:19:35PM +0000, Yazen Ghannam wrote:
> > The DF Indirect Access method allows for "Broadcast" accesses in which
> > case no specific instance is targeted. Add support using a reserved
> > instance ID of 0xFF to indicate a broadcast access. Set the FICAA
> > register appropriately.
> > 
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.kernel.org%2Fr%2F20210507190140.18854-1-Yazen.Ghannam%40amd.com&amp;data=04%7C01%7Cyazen.ghannam%40amd.com%7C83af21ab3dcc4b529ff008d93be354cb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637606669851041887%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=DVzJaZy8OOETbvcISwzhg7%2FP3iHjOiP%2BOgMFd8rrrQk%3D&amp;reserved=0
> > 
> > v1->v2:
> > * New in v2.
> > 
> >  drivers/edac/amd64_edac.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> > index b94067e3952b..d67cd8f57b94 100644
> > --- a/drivers/edac/amd64_edac.c
> > +++ b/drivers/edac/amd64_edac.c
> > @@ -1010,7 +1010,11 @@ struct df_reg {
> >   *
> >   * Fabric Indirect Configuration Access Data (FICAD): There are FICAD LO
> >   * and FICAD HI registers but so far we only need the LO register.
> > + *
> > + * Use Instance Id 0xFF to indicate a broadcast read.
> >   */
> > +
> > +#define DF_BROADCAST	0xFF
> >  static int amd_df_indirect_read(u16 node, struct df_reg reg, u8 instance_id, u32 *lo)
> >  {
> >  	struct pci_dev *F4;
> > @@ -1024,7 +1028,7 @@ static int amd_df_indirect_read(u16 node, struct df_reg reg, u8 instance_id, u32
> >  	if (!F4)
> >  		goto out;
> >  
> > -	ficaa  = 1;
> > +	ficaa  = (instance_id == DF_BROADCAST) ? 0 : 1;
> 
> Or, you can define two functions:
> 
> df_indirect_read_broadcast()
> df_indirect_read_umc()
> 
> (no need for the "amd_" prefix either - this is a static function now)
> 
> which both call a low-level helper:
> 
> static int __df_indirect_read(u16 node, struct df_reg reg, u8 instance_id, u32 *lo)
> 
> and there you either pass the instance_id or 0xff depending on which
> outer function is calling it...
>

Yeah, I like it. I'll see what I can do.

BTW, I'm thinking to include a "tmp" or "scratch" u32 value in the
context used to hold raw register values that don't need to be saved
long term. There are a few places where a value is read and some fields
are extracted, so a few functions have a u32 tmp variable declared. What
do you think?

Thanks,
Yazen
