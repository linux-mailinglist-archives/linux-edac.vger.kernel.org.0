Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E3E3C19E1
	for <lists+linux-edac@lfdr.de>; Thu,  8 Jul 2021 21:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhGHTiI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Jul 2021 15:38:08 -0400
Received: from mail-bn8nam11on2065.outbound.protection.outlook.com ([40.107.236.65]:52160
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229497AbhGHTiH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 8 Jul 2021 15:38:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J55HpShWXFQ2EI4qRoqTF51Fn96/UdQJKK1HIWOkdScjDY1tAqsF9ph8Ldc2iq17GE3YVbgHofQnAdCTwXajcwV0Lk/w9ooYtBheWANGsx/OkkB8leyGGu7A6HFplcYFttdVp2g8vzrcasgtIH7yBXGaaUHuPBZc2yga33DjptWsDA8reLyOkkzmqdq3Q5cSodtEaE1Au7UvlSCp1uibrvglYUvhZWiA0Tcx1e1VeGme0JtWeQLJUkzux4Ah/LmSp6D9v3y8nC/HqTQ8g9X0XMGXQG/qOOxXOx2kefEmBOZtX1RW6Cl75hmCh8uhMP4eDwH5SwUjxiiaz0c1GFAJNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sak4XYXVtoAtArtxkB42NYx+sKcLwNpELzfbSm9ia+c=;
 b=RL/QaF91DLN6eToBsVQwBi0cZj1jJvAVsbbpwpvo43leQwigMmWRKAr+4MOxz/WPJ7evtMdapZYOBK3FKQL+dxYKL5sy9L2zII9kaSU6BWQjvEV54opBwbc15qGSzOpiySINp3zEzSwUXi0XbXvz/vviY+BFoDXUw8O1IzdC3r1Hz5BWoXEUhzxvcFWADBPf8iy7yd2drlgU/Kz4GmTIZ0xq29Kq83Plfb7IIKuLehKLoGqrbQ4XuUkScOC6kWnXWQ3sbaTmtxhcFFFTRueKxiKsqe8XSwCjXbsLxi0FmCyGCInUW2/vdBD1vCgajTTJC1D1i68hCcwn8KHbjiOwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sak4XYXVtoAtArtxkB42NYx+sKcLwNpELzfbSm9ia+c=;
 b=XjXK3/83ptDIpzbjppZilAjdpPz1YVmym0gc2IkCi1DnPw5EwQphykAbRr3inGndsLLWv7gob1UUP+FEtShep6w2L87kMgcGFnKQtIZf1GY08sj/5JeeXxAO8Ao1M8nJL8CAmHqnc2A8vl/U9LyfHN68XWL8NZbJgBT5M+o1c18=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3633.namprd12.prod.outlook.com (2603:10b6:408:49::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.32; Thu, 8 Jul
 2021 19:35:23 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4287.035; Thu, 8 Jul 2021
 19:35:23 +0000
Date:   Thu, 8 Jul 2021 15:35:17 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 03/31] EDAC/amd64: Don't use naked values for DF
 registers
Message-ID: <20210708193517.GA15605@aus-x-yghannam.amd.com>
References: <20210623192002.3671647-1-yazen.ghannam@amd.com>
 <20210623192002.3671647-4-yazen.ghannam@amd.com>
 <YNX0ZLRSLgmm2LiA@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNX0ZLRSLgmm2LiA@zn.tnic>
X-ClientProxiedBy: BN9PR03CA0491.namprd03.prod.outlook.com
 (2603:10b6:408:130::16) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN9PR03CA0491.namprd03.prod.outlook.com (2603:10b6:408:130::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Thu, 8 Jul 2021 19:35:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e14ee3b-0471-4212-cd7e-08d942478773
X-MS-TrafficTypeDiagnostic: BN8PR12MB3633:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB36335A55DA8B9B551D2A83E7F8199@BN8PR12MB3633.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNFur5I0tc/Piia03NZqknl3/V261NvxK9C6+cMWMFXkKZhM2nCJCobUxYKLo/OX43VOY+WX/rZYfR6NzXMXxT8rBxu04yRE0hahN6MXKGrXd8f7FGhHnCQcKlsk8301aLgFRn6dHLJ009GvAC3+XelRPRG4KG1i+Fa8ma0VRMs8NchkcGWVt+iBWIKGnW8wnjtEG1jVWx3Hn4YXIYoYYzDEzMkf/y2FQlktXAsPsCG5ppLnE8qNwqaFrvg0eEZTN4f41FRrKzvhZdLUF9qyHXxTCin164QKLZgxKXGu4kasiHj/uJb0e31sJVG0LdPyOURArT+ZpxNTE21W+KrFK5uBzoP4ME+pZpxcj4VgCIEOlQEHSC+Z85jIDmtbdt4mIvf9WSG6skUCboRlDTwPKCbIdnCyvcGPOcHmvCtRsOfCQBefbwMEONG3Pv9empOY90VSF/u7pGvJLuhC/fc/FV4k0NNNAqI4nqHLI8NR01UZVn1EBFY5qtsiAVkruUzuFOtnBuKcwrrKnNsAdL+1lFKD2hLbHJJgAoowTnxXl/ql2PaaMvisJkyGnJCVXOgC0ns0reqFIQCke6fKRtJ5hNZJCTcY17p2CbW56i6kJchsE/WbJbG7tdGkHxF3c/VA+6QNm9mz510h7qF3kqQvQmcggUqwj2WfmooozxU6De2YqI5bTtLZ/MjIRC+j7pBdOrxHEVDQ1vZqP/ioynz/93toBlcFANy4w0rKJjswvos=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(38100700002)(38350700002)(8936002)(66946007)(7696005)(52116002)(55016002)(2906002)(8676002)(6666004)(956004)(44832011)(66476007)(1076003)(5660300002)(316002)(186003)(33656002)(6916009)(86362001)(66556008)(26005)(4326008)(478600001)(83380400001)(41403002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BF4ikv19m6akFGtEhDWh8zR6y6lUsDYIGFO/UH68vbgMw36bOMTosJHQzx+9?=
 =?us-ascii?Q?vxcHQmpm2dHlCgvzqmKJbgqTHLOfVBXN0K3ZsRi0ye0rR3ZVQBvhWb2VBCLU?=
 =?us-ascii?Q?wFlX4jFmaCfaZw14WYiTr0wZ2CMbTkuYMhbon3AE97zNYaa8KEkIcHU0jPDX?=
 =?us-ascii?Q?/uqIhSsC/HREpbUWVwIHvpAF2LrUJA/JsEMIKFG8ZZNq5GLhUjhW1+oW4mkG?=
 =?us-ascii?Q?AamZGQOCxeTKkzEip6YpPK0as3KKyHswCOYTOZnL8eiGxyaQ0STADxjOTV/5?=
 =?us-ascii?Q?blTOkSUbm1Q0nJWbktXLMT4gzhxWM4InNSO7WIMbBLBTLk1/3ghpyAZmS2v+?=
 =?us-ascii?Q?mQhE6rawWYbu7NMFc7z6NaAbZrZgVFvyNwPjv4J6O+WTmR7BchU692Y7TRkU?=
 =?us-ascii?Q?11gSnzkh00na2HMllQktma3LXnvn5QR1nWQ7YpW6DzMuPH+HRIxAAx7/Fi7w?=
 =?us-ascii?Q?3D8y4h6kPdL/0D0HKoYG3hHQD65hk6LZu9g8pgRrCCqtBBpXxzC6+rELZAof?=
 =?us-ascii?Q?54EEcZXeDcafJ1DLRQ4jqYy7oU6Du85qHUPQjW8CXCVwNoDLQoxvmzF73g09?=
 =?us-ascii?Q?ZeFtA+GeKxjQDDHs1yhyJdmCbRuemfrY8wAx1fsthlPCMi7RvmTT2MzTgwCh?=
 =?us-ascii?Q?c6342vIeQH1xsnfSk/7D3n8BMFvaBTkSU7cpmwFdwANrpcqU9nEKL9daqDp1?=
 =?us-ascii?Q?/2kl4x5gSpgESEdJT2pXNptmGrsadPlXOw1ffGv31of9kjMGAWxzO8VPd/D7?=
 =?us-ascii?Q?4syGcm9uyXJGVrbb5oWKSjm4uIlAjk/2PbLqUgF26bU3q8YJMzSS9ZMM84KU?=
 =?us-ascii?Q?zBktxPpCArnH3f8YtJeNh7Uqkio75hGUy0+gUW7RWM8Tr/lrcqq17PdiVZLv?=
 =?us-ascii?Q?ST3/hb0ARzsrtU6iLazeZVEzs6NZCYw1Y1XESEFDy6DMJ8lEdGQvCG5NtiEZ?=
 =?us-ascii?Q?j2sVf03AdYdu61GIwk07tAtvozo5OmbJdZaY3fJPngTaS6+oKDEXUJMsNcfR?=
 =?us-ascii?Q?nhBQrAukaULH9o3Gq0C7u4VTopkez/aot9xxte4TdKtFwltRvxO+J64NJmHl?=
 =?us-ascii?Q?f2/T2/MDaQtrUYsFZlcZPKcTsr8DihNNb2vGdMtCjKKI7vgiJR3zkrWYWsg0?=
 =?us-ascii?Q?RCKIlUWuPW89YMBjs3HP1pCJIjYm+eOK5+ApTwZvciGgy12c7WHNMVlQEXs3?=
 =?us-ascii?Q?PoNTi1ruD0enUfiW4HTUW44yC2yiZgLLOm0zlyOfbqgKlGiX+EkhChMS9IDY?=
 =?us-ascii?Q?FK4LiSQu2z4yBREp+2VM1zwr7zkDGLkUnGEKlPQE1aVf5WyB9+Dv5R5vWhF0?=
 =?us-ascii?Q?f4yfM7fu8OBqJ5PLCILjfs2z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e14ee3b-0471-4212-cd7e-08d942478773
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 19:35:23.4629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/aAyoi69GVC9wiEc/62tk0MO/cricaEiaXi/gmjKYrZ86iH3QgQTIYITzDJDZc/gPWe8onHQhWW1ddLNne8Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3633
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jun 25, 2021 at 05:21:08PM +0200, Borislav Petkov wrote:
> On Wed, Jun 23, 2021 at 07:19:34PM +0000, Yazen Ghannam wrote:
> > +static struct df_reg df_regs[] = {
> > +	/* D18F0x50 (FabricBlockInstanceInformation3_CS) */
> > +	[FAB_BLK_INST_INFO_3]	=	{0, 0x50},
> > +	/* D18F0x104 (DramHoleControl) */
> > +	[DRAM_HOLE_CTL]		=	{0, 0x104},
> > +	/* D18F0x110 (DramBaseAddress) */
> > +	[DRAM_BASE_ADDR]	=	{0, 0x110},
> > +	/* D18F0x114 (DramLimitAddress) */
> > +	[DRAM_LIMIT_ADDR]	=	{0, 0x114},
> > +	/* D18F0x1B4 (DramOffset) */
> > +	[DRAM_OFFSET]		=	{0, 0x1B4},
> > +	/* D18F1x208 (SystemFabricIdMask) */
> > +	[SYS_FAB_ID_MASK]	=	{1, 0x208},
> > +};
> > +
> >  static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
> >  {
> >  	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
> > @@ -1059,8 +1091,9 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
> >  	u8 cs_mask, cs_id = 0;
> >  	bool hash_enabled = false;
> >  
> > -	/* Read D18F0x1B4 (DramOffset), check if base 1 is used. */
> > -	if (amd_df_indirect_read(nid, 0, 0x1B4, umc, &tmp))
> > +	struct df_reg reg;
> > +
> > +	if (amd_df_indirect_read(nid, df_regs[DRAM_OFFSET], umc, &tmp))
> >  		goto out_err;
> >  
> >  	/* Remove HiAddrOffset from normalized address, if enabled: */
> > @@ -1073,8 +1106,9 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
> >  		}
> >  	}
> >  
> > -	/* Read D18F0x110 (DramBaseAddress). */
> > -	if (amd_df_indirect_read(nid, 0, 0x110 + (8 * base), umc, &tmp))
> > +	reg = df_regs[DRAM_BASE_ADDR];
> > +	reg.offset += base * 8;
> 
> So this looks weird: you have a df_regs[] array of all those different
> DF registers which I'd assume is a read-only thing because, well, those
> func and offset things are immutable, i.e., hw registers offsets etc.
> 
> But then here you go and and modify the offset.
> 
> And that df_regs array is globally visible in the driver and if some
> later functionality decides to use it, it'll see the modified offset.
> 
> IOW, I'd make that array read only (const) and use local vars instead to
> pass down to amd_df_indirect_read().
> 
> And I'm also questioning what the point is for that df_reg thing?
> 
> You have them defined but then you have to change them.
> 
> I.e., you can just as well pass in func and offset separately and be
> done with it.
> 
> But maybe there's something else happening in the patches which comes
> later and which will make me go, ahaa.
>

You're right that the values should be immutable. The changes done here
are only for this pair of base/limit registers. Most of the time we'll
only use 2 pairs (4 registers). But some systems will need to look at 16
pairs, and so this current approach seemed nicer than writing out 32
registers with mostly redundant information.

I was trying to make the code more "self-documenting" and move away from
magic numbers, etc. But it all looks okay to me, so I'm not sure which
way to go (magic numbers + code comments, something else, etc.).

So I'm inclined to stick with passing in the func/offset values and
dropping the df_regs thing.

Thanks,
Yazen

