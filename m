Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8BC3FE279
	for <lists+linux-edac@lfdr.de>; Wed,  1 Sep 2021 20:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbhIASne (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 1 Sep 2021 14:43:34 -0400
Received: from mail-dm3nam07on2043.outbound.protection.outlook.com ([40.107.95.43]:45408
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232127AbhIASne (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 1 Sep 2021 14:43:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEdKguLI9HRR1XBxBDj5FTxJcQk3V/QgPwZErQyNcoy8RYD6ibQInIqBB0mcaajhozyJ41obcoLr8CbhEHRD/AEEk4bAyFDG6akvd9qsuQ/hdKojOMH3wy8Q3kkss0lKiH6/PKgP7wD5lUs+YtdVbTl9aISIXfel8thPmJFI75YGVggV5iGU5DvcyuhwOEmj7b1Z31zeF3V47QHTOHbFO/0QGsn+pgE1z+iw/XhF8qtJhDUU1aOY3ELJTxe1p5Gd19y1C6OW33AC246N/AKehsRhOmHLTmlIb43JtEy4KHh6yCibdWVAzQo/xb4QNtkCjSx9FiJLN2SDZ5sSWi5ahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFfYc2fbnST4CV4Hykh76Ugrnbn8wPdYxuVOU8n/oIQ=;
 b=XHHDx6nq9mdtk21BQPpi444W9ToW0eMZEi7FJfFoZ06+UW/Mgw2Uh17VATnm8dIhc5GqTcDIJ1MRUCAfAWwkbhRGZoFOflInfWS8K6vOk18+ESznendRLdMsSrpzI5sIZg6YIBVp6gZqjpw9bar6g0CeNhLacjs091ZlfUx58D4SwgPnh2rYlBCZovxwJh1LGGkx4qZtztnRGoVVp27t/0GdQpyD1A/3aU+yjDOugzwr0xHN/boKPp5i11n1HlTRhOqdEm+b4vxf5cKnuVdQjOgRrYTULUAowKLXrN4JvvOC28zFB+mspEYyHHEPpDswZTGYOmL16jGCD+xj3Tc/Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFfYc2fbnST4CV4Hykh76Ugrnbn8wPdYxuVOU8n/oIQ=;
 b=KRtvTMotZwoJH2KNut6q1rNfDeNQmH2PE9+C9HMXTXo1vUN2UdeqP0kuSx/PEsw8J6rbYU1Lf97ne2VO37FhNO56BbQFRc9nwdaaToTvXX4LuWMzXCyv4BGAJYONJ2h65UXxl2H41RSBfEUVtunt0noWaL++YfumR3Pq2WeyBZQ=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB2481.namprd12.prod.outlook.com (2603:10b6:404:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 18:42:35 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::dd2d:805d:50ad:33c5]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::dd2d:805d:50ad:33c5%7]) with mapi id 15.20.4457.025; Wed, 1 Sep 2021
 18:42:35 +0000
Date:   Wed, 1 Sep 2021 18:42:26 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Naveen Krishna Chatradhi <nchatrad@amd.com>,
        linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v3 3/3] EDAC/amd64: Enumerate memory on noncpu nodes
Message-ID: <YS/JkgWA8VreIx1R@yaz-ubuntu>
References: <20210806074350.114614-4-nchatrad@amd.com>
 <20210823185437.94417-1-nchatrad@amd.com>
 <20210823185437.94417-4-nchatrad@amd.com>
 <YSjM8b9vvkmRew94@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSjM8b9vvkmRew94@zn.tnic>
X-ClientProxiedBy: BN8PR12CA0029.namprd12.prod.outlook.com
 (2603:10b6:408:60::42) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ubuntu (165.204.25.250) by BN8PR12CA0029.namprd12.prod.outlook.com (2603:10b6:408:60::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 18:42:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20f08b25-018e-4b2c-09a0-08d96d78438f
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2481:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2481B4F537D92C625268B6A3F8CD9@BN6PR1201MB2481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJAoEWfAn915lkYuN8/+Jmn8fnQIWbNuf9CH4WBhlLPUAjMWdJZES6Ze2kSJ1uJWp45V9SHqqCmmFLDfezWg/xBXhA0862zf+M9Di/TgixAouzLLrILG3OznzG5a1IER5uonkk+YoafopuZ8Al6CXfj+0VyncmORzRKOYptzwX0UrJjF1nagu6B+F6Pa2tJsM/qi1He9Yp/EkUBvycRRQsz7qqBSrtpIGbzM2uYf4QuaiS+XxZ0AKMXalYAkabP3mqaHTvRDMiD3XTsZnocy97UM30jPXBumQRV5KunJl6RgdDUWkfoSByKPMmYYQV/jMgQ+M+LKcXofXzb8HWbEyx7hB0DYQjjsnfBXFd4j299xDBzQu/6qqKTqFQusmJHgJOvipUcbiugbocERkClJmbvsx8sN+s1UxRLhd97cVuRnLhMAtm26Ue7FXZW4A87u6LAcEPKCC9tmxwaWZYl8iRivUHQPrsG4ZvvxeLkzBub6eWXJRggYB+WH3QC+DNOtATwRryaof6t3/ok3ChtxWtiAZ0VKUBjxg4fH41CYIP+EED3RDMHQpzn1KvQMkbKeRdnf6hQyGHjD2eEvyWgsXoIcic0AsOa1OAz/oj+UtXTjCXQeRCx/wzW3V9zTlnv3+mJ2FpNyuxAHebS4FMvaTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(66476007)(38100700002)(66946007)(478600001)(66556008)(186003)(33716001)(26005)(8676002)(44832011)(5660300002)(6916009)(55016002)(4326008)(9686003)(86362001)(2906002)(316002)(956004)(54906003)(83380400001)(8936002)(6666004)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ySwHD83kiwwYdZlUJHd8V5UcZgQattHCtakDAuaKexV1YnBpY4b4EzkTJrIn?=
 =?us-ascii?Q?P5Xf7MSMXLeg5YcJrARFRLGn2kn9d7pgmReiY0iFyvR8nAYR+YGqlMJbNJcY?=
 =?us-ascii?Q?qRCA50dbpEdysTT/k5nfFU7pyCJjbWWu4b/fIzM3U+mrxTiZ0EAbAbyMcZGW?=
 =?us-ascii?Q?6okJA+wUCWssBItFPsP9XKTW7kKPVH93Lx3ufjzaVY6mPAssvziXIUec8G+w?=
 =?us-ascii?Q?GC4zBN9rpLcJItKkilpe4nz8r/KwI7bQ6Tyqdb6HI3/mHAJ4kGxQanRcpNDA?=
 =?us-ascii?Q?3HRuRAIVzK84fU4buXeHQsMolp78KvrtV2VpyslEAcR87Y4HfQDVe2KrW4Eq?=
 =?us-ascii?Q?1ib0WXN04f6OAEVEZCSZlRRygfs/makYcqPw+YQaYQ8NUxoDfGDgUnLie8Ih?=
 =?us-ascii?Q?EkLEfSxqyLixdJFvwbYszxXXGMvF5olAv3TUxturcP8OAfCbfQmcgHpRaR5l?=
 =?us-ascii?Q?l9jr+02sDI4tKra1/fm7115d6EqKTQGIRcxtgBeO8SyMg4XaIBj6g1KUMUoh?=
 =?us-ascii?Q?vm14FH/Wg65D8JBXJx3GA19sszu1q+xSnB84OK+DMeNYsG1E54RtFdsTyFDV?=
 =?us-ascii?Q?eC/L5E/WpDwCyO1Uh2Y1Q20xY4OjJLkzzo56+K6GULJOo8BkPONb/zbEZoyq?=
 =?us-ascii?Q?m7lYRrG/wSAKLwOkbIdQOBszqvCwv9LlmOqx643Twa7OLAVz3M21cjnYSz3G?=
 =?us-ascii?Q?3Q/X5wjGKKz6tMBcOGeUKuGneqmRP16Ug9W7b0+R8IbgXIIOH+GMiUGoBFo9?=
 =?us-ascii?Q?Hq/+r39PflKT7nVx55v3drOSGTzPDQbAiTOfZYeUz/6ZW3+6qCUEk4Rc7n08?=
 =?us-ascii?Q?aECS3kpAYQ8THVhvpmR5YfO2ekiPUSnpG+oEdQ3pPyndUIhwfr3dNIs1gKuX?=
 =?us-ascii?Q?cwUtRLo2Tj1enE4vT4IKEekIYcB0+WytriobWzKer0Ix/kmyWje5z7sYU+4v?=
 =?us-ascii?Q?6cXHMJzXnkTgn2ryEy71pa5rykzuwfHoezQ0zjCYQ8z+F0FodRW032RSX7rE?=
 =?us-ascii?Q?wRcGZWp/wyiFBVcjWAuEnRzaHA2o6/nVmL+sC1qCCSq9pQcQGOl8mfAX6OPW?=
 =?us-ascii?Q?dxUQZ4qE1trbcxSfyDKan/nt3RcQI1Chu3k1t2i9XEJlSJdrXhM/tuPd/XQf?=
 =?us-ascii?Q?wDCnngvir+uroJV3FD2snrA/AtTYE+KSiCs+uTqdHfxahhUsqAhFbaLqwzBx?=
 =?us-ascii?Q?anm+2J/g7uO5WcasYouVwyVZimhpbasR0tshlRImvHeOPbQGr0rhHDir6All?=
 =?us-ascii?Q?/XfAgqzWTRa+/ANcLWZoFkl4ckG3TrM4ym/GjfYQLtmaAGSMagd9goI8h1Ip?=
 =?us-ascii?Q?x/DkA7NCKn4nW+dfmW+CCZDv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f08b25-018e-4b2c-09a0-08d96d78438f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 18:42:34.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbxSqSxghhlMXmOCp3DcNAvTysDdpGuoKJlO374KHH9xPxUdXXyO6v6GczL/aClOBU7T2hr67Vmrc3zN+tJ3uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2481
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 27, 2021 at 01:30:57PM +0200, Borislav Petkov wrote:
> On Tue, Aug 24, 2021 at 12:24:37AM +0530, Naveen Krishna Chatradhi wrote:

...

> > @@ -1335,6 +1392,11 @@ static void determine_memory_type(struct amd64_pvt *pvt)
> >  	u32 dram_ctrl, dcsm;
> >  
> >  	if (pvt->umc) {
> > +		if (pvt->is_noncpu) {
> > +			pvt->dram_type = MEM_HBM2;
> > +			return;
> > +		}
> 
> I don't like this sprinkling of "if (pvt->is_noncpu)" everywhere,
> at all. Please define a separate read_mc_regs_df() or so which
> contains only the needed functionalty which you can carve out from
> read_mc_regs().
>

I like this idea.
 
> > +
> >  		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
> >  			pvt->dram_type = MEM_LRDDR4;
> >  		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
> > @@ -1724,7 +1786,10 @@ static int f17_early_channel_count(struct amd64_pvt *pvt)
> >  
> >  	/* SDP Control bit 31 (SdpInit) is clear for unused UMC channels */
> >  	for_each_umc(i)
> > -		channels += !!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT);
> > +		if (pvt->is_noncpu)
> > +			channels += pvt->csels[i].b_cnt;
> > +		else
> > +			channels += !!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT);
> >  
> >  	amd64_info("MCT channel count: %d\n", channels);
> >  
> 
> No, a separate gpu_early_channel_count() is needed here. There's a
> reason for those function pointers getting assigned depending on family.
>

Good point.
 
...
> > +/*
> > + * The CPUs have one channel per UMC, So a UMC number is equivalent to a
> > + * channel number. The NONCPUs have 8 channels per UMC, so the UMC number no
> > + * longer works as a channel number.
> > + * The channel number within a NONCPU UMC is given in MCA_IPID[15:12].
> > + * However, the IDs are split such that two UMC values go to one UMC, and
> > + * the channel numbers are split in two groups of four.
> > + *
> > + * Refer comment on get_noncpu_umc_base() from amd64_edac.h
> > + *
> > + * For example,
> > + * UMC0 CH[3:0] = 0x0005[3:0]000
> > + * UMC0 CH[7:4] = 0x0015[3:0]000
> > + * UMC1 CH[3:0] = 0x0025[3:0]000
> > + * UMC1 CH[7:4] = 0x0035[3:0]000
> > + */
> > +static int find_umc_channel_noncpu(struct mce *m)
> > +{
> > +	u8 umc = find_umc_channel(m);
> > +	u8 ch = ((m->ipid >> 12) & 0xf);
> > +
> > +	return umc % 2 ? (ch + 4) : ch;
> > +}
> > +
> >  static void decode_umc_error(int node_id, struct mce *m)
> >  {
> >  	u8 ecc_type = (m->status >> 45) & 0x3;
> > @@ -2897,6 +3003,7 @@ static void decode_umc_error(int node_id, struct mce *m)
> >  	struct amd64_pvt *pvt;
> >  	struct err_info err;
> >  	u64 sys_addr;
> > +	u8 df_inst_id;
> 
> You don't need that variable and can work with err.channel just fine.
> 
> >  	mci = edac_mc_find(node_id);
> >  	if (!mci)
> > @@ -2909,7 +3016,22 @@ static void decode_umc_error(int node_id, struct mce *m)
> >  	if (m->status & MCI_STATUS_DEFERRED)
> >  		ecc_type = 3;
> >  
> > -	err.channel = find_umc_channel(m);
> > +	if (pvt->is_noncpu) {
> > +		/*
> > +		 * The NONCPUs have one Chip Select per UMC, so the UMC number
> > +		 * can used as the Chip Select number. However, the UMC number
> > +		 * is split in the ID value so it's necessary to divide by 2.
> > +		 */
> > +		err.csrow = find_umc_channel(m) / 2;
> > +		err.channel = find_umc_channel_noncpu(m);
> > +		/* On NONCPUs, instance id is calculated as below. */
> > +		df_inst_id = err.csrow * 8 + err.channel;
> 
> 		err.channel += err.csrow * 8;
> 
> tadaaa!
>

err.channel still needs to be used in error_address_to_page_and_offset()
below. So changing it here messes up what's reported to EDAC.
 
...
> > @@ -3804,6 +3963,9 @@ static int probe_one_instance(unsigned int nid)
> >  	struct ecc_settings *s;
> >  	int ret;
> >  
> > +	if (!F3)
> > +		return 0;
> > +
> >  	ret = -ENOMEM;
> >  	s = kzalloc(sizeof(struct ecc_settings), GFP_KERNEL);
> >  	if (!s)
> > @@ -3815,6 +3977,9 @@ static int probe_one_instance(unsigned int nid)
> >  	if (!pvt)
> >  		goto err_settings;
> >  
> > +	if (nid >= NONCPU_NODE_INDEX)
> > +		pvt->is_noncpu = true;
> 
> This is silly and error-prone. Proper detection should happen in
> per_family_init() and there you should read out from the hardware
> whether this is a GPU or a CPU node.
> 
> Then, you should put an enum type in amd64_family_type which has
> 
>  { FAM_TYPE_CPU, FAM_TYPE_GPU, ... }
> 
> etc and the places where you need to check whether it is CPU or a GPU,
> test those types.
>

This is a good idea. But we have a global *fam_type, so this should be moved
into struct amd64_pvt, if possible. Then each node can have its own fam_type.

..
> > @@ -389,6 +392,9 @@ struct amd64_pvt {
> >  	enum mem_type dram_type;
> >  
> >  	struct amd64_umc *umc;	/* UMC registers */
> > +	char buf[20];
> 
> A 20 char buffer in every pvt structure just so that you can sprintf
> into it when it is a GPU? Err, I don't think so.
> 
> You can do the same thing as with the CPUs - the same string for every
> pvt instance.
>

Fair point. I like the idea of having unique names though. Is this possible
with the current EDAC framework? Or is it not worth it?

Thanks,
Yazen
