Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A720E3C1A59
	for <lists+linux-edac@lfdr.de>; Thu,  8 Jul 2021 22:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhGHULP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Jul 2021 16:11:15 -0400
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:42656
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229866AbhGHULP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 8 Jul 2021 16:11:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHpC8oUqqOgOGb4gxHLDFFFpTHVhyLDF1/u+/oe3B7UKPVlD21uW39bx5kcVTUFkDkT4giSxE8meNts2eewwTO43Q2AlYhkRGjipXIEoXjDyeVozZU5Od2NFbikUd9pXr9nOVpnymEwFs4fj/lkl2SVkfiDhJ2IFYQqQ09/eJTJ2hoHnvzK2uzhnFiecuK+zPHF1eDe046AsrP1R5w/c/vX5twgGo38d6Y8DI8EWiWFP/xMmUioiJ23hg/BtUN7QjYWDAPDFSqOB/3j4hDzHqtfGFOpbJZVYbHHYfna2u+UjyYDYwnV/CzuXMRCe5eQFFcKn5IT8r/hqcVOXbyRGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpgfFbv13sdWUR1qXXR6uqN0dvSoGQs+Z2Oi/7mLKRM=;
 b=ne8rhwdqlNYgAqg7qfgS+kXA+ATx7GZIcyc66FAkIjjfkUkhKTVivEplV7HztNri8YKj1Jy/5ROqoYGLs7lC9IWDaNbhJ+iF6tqUqjHYKv6uqz+0qTwenH1VgTWd2AtsepQEtlMCMmJZBeFjQbhSWV8GsFyVMO86Q3LWV4wfoGe6CoUobEJ0iYPWgk5mhIGbwiMyu+BSV5aY8dCF5GaDtN7HRN4ywvJ5PtzHtHdlbiASFBEozVcUW60Cc1GRFnTQ6QmFu+S+J2SJKBUzpWTxjpx/djdKz8Bk5ktWTg4rS4OquKJX7jVxI3m0u1XTdt6rFDNLDvKlcLgpd2N2sRDc2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpgfFbv13sdWUR1qXXR6uqN0dvSoGQs+Z2Oi/7mLKRM=;
 b=am8IEjF4qummxbajG6qKvL0Gxu4SaFMYioYF6p5JMdyFGjtbj8DzTkAoUiclmUav2R6h1CxzU3J8xAjCLm6B/PQ4mrgbMjlvvS1bWZnzphtb/gie5DLoqBHqJGVsjN0g7QDs6sd27VcsJK+f6YaDXg2mIooB7Rd2izH3VG6k8CM=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB0083.namprd12.prod.outlook.com (2603:10b6:405:54::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Thu, 8 Jul
 2021 20:08:31 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4287.035; Thu, 8 Jul 2021
 20:08:31 +0000
Date:   Thu, 8 Jul 2021 16:08:28 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 07/31] EDAC/amd64: Define functions for DramOffset
Message-ID: <20210708200828.GE15605@aus-x-yghannam.amd.com>
References: <20210623192002.3671647-1-yazen.ghannam@amd.com>
 <20210623192002.3671647-8-yazen.ghannam@amd.com>
 <YNypa1iphyIuogtZ@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNypa1iphyIuogtZ@zn.tnic>
X-ClientProxiedBy: BN6PR19CA0115.namprd19.prod.outlook.com
 (2603:10b6:404:a0::29) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR19CA0115.namprd19.prod.outlook.com (2603:10b6:404:a0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Thu, 8 Jul 2021 20:08:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 285294bc-d0e2-4a80-8a39-08d9424c281d
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0083:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0083C7CBA941D86E899B0A42F8199@BN6PR1201MB0083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UCAL+gOKahV3dyrkbEAx7L7fuop7y8+E5pC3KPshdBdxX6y+TszhtXIN3MmJ37kqfFG0xiMBauC4xV1yrEghTwJ24uG26ozubbvbNVDT/biYD578zmqAuHUh5imzWIOy3Sw+/sW3TLTZcaQ0TdLM8ZQYGaRTrRNBiFI2oPnqi4yr6PPk9l8ROjG8XoUPOUFHRWm9ogEosWk58fiQmdTM+s2csxnwl1XJM9yvRDKheLjJ1pl7CURPREvAk8tOJzinQORkFGCYXOadbKjMjbIWSCKVtWTpvLED0Skg0T01zJYBjXLMScLRLvCko62j32nLaqslR8Aq3TD3NR+7VS6z72VLiz5JxDuRtHmOyYBtMb3tpVOFtHamqc5BZKW4Vh0KNXc2cFu+p9MAhHxXG5sdREsahKK3JvPIkDR5BQ8vp/melOgDEtg/x+IAPFD8BKNAYZbVvs8vKCTUnVl6BvIESSIqKYS53t5Nxw7WguT9dIt4Lg2qGAt8qPGUKqdxamCXlxhIDo6IUve/8kgXDTA9jfTPFHwfFhJiVapyZORsbr9pFU+Q6/TTbBsQgBqtW8KSqtyhZquVLrq0g4PcXl3A51qXsZdXx+/ucXznf7t+KRNKOsLWj4kRKi0ub/0PxUr0P5Hgp6yyzAZ33C9SxGwQNYoeiOKJlYq1WZt7UX6rO43b27D6P3j82eOFBeqKn3P1om0a6YMVkqMFFLGT5OCD7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(38100700002)(66946007)(26005)(316002)(956004)(1076003)(4326008)(66556008)(66476007)(86362001)(2906002)(478600001)(52116002)(186003)(7696005)(55016002)(5660300002)(8936002)(38350700002)(44832011)(83380400001)(33656002)(6916009)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mndZMZxKG688cUdxXjA9Xsiz5pySYVQH3+7566jRgQMLdS61wT/44XSP6Q0i?=
 =?us-ascii?Q?+aakbtO0oZCMK0Kt2Mbg6ZFvjgahr99XYwJ57Xybag1q8575NLT/MNdkW0l5?=
 =?us-ascii?Q?mhTnjUKwPGmImI7F0RyadPBcNMabfkiMgWdsDG8rITqYfmeKNKvzv77+2T6r?=
 =?us-ascii?Q?9R/IzGWh5LQNUhTQU+TqLS/kzhv/N3iCkHYr1zY9Nn2BawB5EQZO6CkBMWfm?=
 =?us-ascii?Q?7xGrVS4whoqGEkzT+77E5ZMLQ/OxIWCDLC3kqQBovagBBlRWyzCR+whlu7O7?=
 =?us-ascii?Q?/+keqkoM3Zur3O6W8Mc73PmFYIhnOA4KOW66zs27jy0Bb3QK4fpWYOddFfdP?=
 =?us-ascii?Q?sPGe6o8Fky8sehPYhdrGijEJocn0VeAvM45IHGdzpBP148DWPASVscDUdIvE?=
 =?us-ascii?Q?qXF3ezdOg0Es97jF7HAQf3RU7MSlfYC20nx+YXs5yBNZCJ29GD3f9RdobL4H?=
 =?us-ascii?Q?vYK1HSeQUZwWR+lzmm+6gy55fgH4XE8ZIwpeG2LZJleGT5be9Ccrw5Msdk8j?=
 =?us-ascii?Q?pLkGAW1mAVIHmBMqaC4WAgcg52QRMkn8h4KWuZRrFzvkLvcjwE/OsgN/gBJh?=
 =?us-ascii?Q?ivYFfKW5oKFE/7aGrnB+YL/EkMpQEtfdzok9bjtSLogUuAPvWox87gFYteer?=
 =?us-ascii?Q?aH6WD0Fz4KsCLZf7syYnJH2OmnH1V+b054gGbTwZ6s4gkH61uYVAsBmhV7LK?=
 =?us-ascii?Q?bfMacEYpELB4lga7oVTM+seWDP5tBLxmfAA/jWQuScSzxstWeDEO2t0hHY+/?=
 =?us-ascii?Q?+TxkpfPL6cCZvoDDisb9byliB6ARbRCutPjhKxjMqvOwm8sXoKGnHxuVomh0?=
 =?us-ascii?Q?Vx6H+J0elO+8WiF5n4H+spdSDj5IDPB55GOUiZwas1cKRrOQmV3YLCpWF028?=
 =?us-ascii?Q?va1GVpFjXtAky8+LpfhcycZ6OqFh/odIH+HKumnh+Rmm5V5mwZeHBoTc/DDl?=
 =?us-ascii?Q?6atWVGvtvA8VtooyYThWAj3g7/xkJNH94pk2FXmfrJmzMBfEEClKCKY79vDg?=
 =?us-ascii?Q?ZumnUAzkMGJx7Ek6HEwiZiIxDgcZBMTXve9aUK5BDa9ShSnmscwqw99DxQul?=
 =?us-ascii?Q?HgL6pi6+gdObO9dqt9J/j1uiemosuw8y3BLh7TXqC8fYIY+FYeTmxv4HbzKh?=
 =?us-ascii?Q?OLFa1SDFFwF/SC4EQaxMyDB2HoJLm32X8eAT0Q6yKwM6ERSzrzPWWmQ4/02K?=
 =?us-ascii?Q?92BVwpEGTUwvpQZBmCElBayPUarTULSx8mrWxBhC473wNgZl5S2KktoMb797?=
 =?us-ascii?Q?9dk+0vTZxiuUedzHAfqMjOBYGkuGyklCb8fi794llKiLla94CieP6ifuwAHh?=
 =?us-ascii?Q?iL3meQkic/G+Hth9NpT3KKxP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285294bc-d0e2-4a80-8a39-08d9424c281d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 20:08:30.8997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7b9YtxGWEN60hnpPh/k/Xf0PX71p59eb2QE0IyMnQS7bmxDZ4a/FVWPMbzQnlBRhVJTyjSKEytLZjD6ua2oe7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0083
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 30, 2021 at 07:27:07PM +0200, Borislav Petkov wrote:
> On Wed, Jun 23, 2021 at 07:19:38PM +0000, Yazen Ghannam wrote:

...

> >  struct data_fabric_ops {
> > +	u64 (*get_hi_addr_offset)(struct addr_ctx *ctx);
> >  };
> >  
> > +static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
> > +{
> > +	return (ctx->reg_dram_offset & GENMASK_ULL(31, 20)) << 8;
> > +}
> > +
> >  struct data_fabric_ops df2_ops = {
> 
> Those "df2" ops are for UMC v2? 
>

No, Data Fabric 2 is used in the first Zen products (Ryzen, Naples,
etc.)

> > +	.get_hi_addr_offset		=	&get_hi_addr_offset_df2,
> 						^
> 
> No need for the "&".
>

Okay.

> Also, if you define a member ->get_hi_addr_offset in df2_ops, then you
> need to define that member in *every* df_ops structure you have so that
> there's no NULL pointers.
> 
> I guess that's coming...
>

Yes, a function goes into df_ops only when details change between Data
Fabric versions, i.e. different bitfields, registers, etc., but the flow
is otherwise the same.

I'll give the NULL pointer concern more thought. I've tried to cover all
code paths and use cases testing on real hardware. But it's possible
something can be missed with how configurable our systems can be.

Thanks,
Yazen
