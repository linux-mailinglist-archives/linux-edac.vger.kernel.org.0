Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6293A490B3D
	for <lists+linux-edac@lfdr.de>; Mon, 17 Jan 2022 16:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbiAQPPD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Jan 2022 10:15:03 -0500
Received: from mail-bn8nam11on2066.outbound.protection.outlook.com ([40.107.236.66]:55680
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234737AbiAQPPD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 17 Jan 2022 10:15:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOKH161pxPG/IzyN/dS65LK83xWoi9vbUzaTr9/9g1TXfRZvLm5o1xQVujBGUMKLhlyci8QGve1yPM+HhzYlo9d38gOSLTQfkH1wtVAvt9d2XSyiH5JcDgTGs8LVr2EodMHOfKAXc93/Tl2t8HH4XWqjdFmCwKKoBKSsI/u7jAWAdo6dP5sq1VdejYqj9gbPbsBmTr/NIR51o0SF2KtQoEqdOdUAkorbGHVxxq06u9rSWlUjrv3O90Dr2TAh2MDb9ZT+uvmmgTb2HhWhENL8Tpd3bqvLn45kp2eN39beBYwQisHhq4rY77DtvqqtNQkzvt9Wa4jSvEVJv7ExeIIPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTKDgHxiA1wyIVSxzACgxL+PEiMvbHLCC1I4CmzPNhc=;
 b=K8UlAJ1EwfjNm4y1a6uY41SfFTrQJNT4RTKPULOF3J7h0ZQZPm66tdiRlk/ocj2XoAYFhYfv86cGyQYluPKkLltEHjp0dvvXEsIJtMUI3xhacISujQva3l4wgKloayAQuVQOCwRNJurdQJzSObGqeig3OxFicjIQZ0JD88ccBC6y2PZdTNHnGFbo7IaYGRjW4rJNTXvqRHMGkCxEvlTsn+3m9Yp8RNOC3aYATjU2w653DLsO13XkHx7L6QEOHawQXE9y417/IhdZFMH4Z4UZjct5BErUYRMEek62rnqV4El2TiYx3FqJ2Gp2+jFnvoLHrV2G53McTAgI3Cpi1uWt8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTKDgHxiA1wyIVSxzACgxL+PEiMvbHLCC1I4CmzPNhc=;
 b=CSb5uFfQfFyGH3nAtdcCkUS9o86ixaI6kZ9j2TnBkj2eC8huOEX7oZOnexMu/8y6/TrQMO/pzIglAvXd8cXgd4W3uuscbciK36f/71/Z5Xu7Sgn0ZYICg2Wst5KJdPEIYxQgVIXxd3x8uuJ7+c7Rbw/bDyOo++ZrnqaJg+h3zU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM6PR12MB2844.namprd12.prod.outlook.com (2603:10b6:5:45::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.13; Mon, 17 Jan
 2022 15:14:56 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a%5]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 15:14:56 +0000
Date:   Mon, 17 Jan 2022 15:14:52 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH] x86/MCE/AMD: Allow thresholding interface updates after
 init
Message-ID: <YeWH7EEGXo5CyvoU@yaz-ubuntu>
References: <20211207193028.9389-1-yazen.ghannam@amd.com>
 <Ycyd+nYgXvJpL19y@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ycyd+nYgXvJpL19y@zn.tnic>
X-ClientProxiedBy: MN2PR20CA0055.namprd20.prod.outlook.com
 (2603:10b6:208:235::24) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba0636b1-6a24-4dc0-f770-08d9d9cc1eae
X-MS-TrafficTypeDiagnostic: DM6PR12MB2844:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB28444F1BDBB56AF1A4C78F08F8579@DM6PR12MB2844.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EHAgU6+JRxwgTwQyei1Se7c2RyQW7OgpsNiDF2b6STJcYhFwaAc+yiOEHjKwLtEs1Bs3+XVrUGSbZ7pOmG3BLQcddoystwmnzpqmPZsYzqwv6eZ9Wq2ofGiO+ZEdISG6rg9C4GoXQCq9PTzXzzxbHFcA51Y+68PwF7VdYvdUxklGd67DTF7fqYVKeW2aItlMMWcs4BpV9Te1EoEDHwZngSWjJA1ePJv+YSQfUK0BtO8wwGMBgpX2TWwbJI0s69cb2++9ng4wnGqpV3zXWk7KZSS+OHlL9R7/gyS9c1znjdoWnZ1POG2y6LSnrazz+GAl/mylxaaLCVYjNEmj/m3eYUDt/Ci2fYG2+zsilTAgFYcLhTB2WIRZA/0ZJmKsHBu5gJkLQ+CRO3y0NWXOnCZ6xbvp+1aLwieMmqEe3urjnPAAZ+mqDh4Y2Uipm1lzpon4AbiyTqjBTeLnxovuVpSCqRncrvCzJSVOVIc/DUU1mcwmFY2CJ6kaPILY2973jQ/aJbvi0xk7pRJh4Ux0Ffk9Z5TYSxApEDW/4vd1rf1+SBo8NfZukLji84gjCk2T4EGAa1dXCiRBMGRVGQ4tv+P/oBREuySy0m6QV7tst3oF5bQG/wiBB1rPOtM/b4yUuAL7k6qZ0f/6yaA/lhCV/ATcXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(6916009)(5660300002)(86362001)(2906002)(186003)(508600001)(6506007)(66476007)(15650500001)(6486002)(6512007)(9686003)(316002)(44832011)(6666004)(66946007)(4326008)(8676002)(83380400001)(8936002)(33716001)(26005)(66556008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4nqawoIScYYMgO0xiH6Ad+oTvya+Y+ujtyRfSfGuKiJUMVgns8/kZKW4bObr?=
 =?us-ascii?Q?y80Bak9yWxBYFS8dEkiJ7DwvOsxXNowhfUh3uD5TvF9VfgMX26BNIEBYn3/j?=
 =?us-ascii?Q?b7wZxng1868D7QzrUQAoCMGhIFohaG6rAwInL6s+mjpJkTG3sGaEXfbFRGYm?=
 =?us-ascii?Q?nji1rxqwliIy1mAKwogwohnfqBYOgmtR7nS1HrgdhIYmVhO6YL0jNn2jqhLk?=
 =?us-ascii?Q?nyCy8VsIDZmokoupgSzyUlOJ3CKmYE8db/JGOw0N2EexqmYFCPBEzlAtJJa4?=
 =?us-ascii?Q?Gmzn1OAHCJ2/D3VTd733tcA31Hz3kIHvvzUOxrueEXhL/h+zad5AfUVdIXsW?=
 =?us-ascii?Q?raSWf3WnJIR5bLw8iw/QdqPIUylZdytFiWL5G0szH49SQg2fGAJFks7bIwXo?=
 =?us-ascii?Q?Y4uN9LQjrbPXmnyJE5T54OJgqJfvU/gO7RTfDI7AKpfbams5lJ3b+Lbp3ah8?=
 =?us-ascii?Q?VraepVOFbkM5MZYFTJrop4Y4Wmt5VT6O4WhseIs9BTEgfAURvqlKj6sMYO0g?=
 =?us-ascii?Q?RrardRUpThBoyXhDKQCWnmGdISAwyvtAtgviko3dvh7OCQUFoakQJ9ZgomJx?=
 =?us-ascii?Q?2JCGlI0sVMcwigdJFdNZiJ3Z2lR3/Ym+6UezgjcV8gtTWwOkU/mcnnAbkK/S?=
 =?us-ascii?Q?9KmUaeZJUpXAaGblImKQ7pVgR7sJNQRUmEfwrcmGWL3PcOsjy7bY02JdBMea?=
 =?us-ascii?Q?WTVq32xL5G4esdVKGb0hFhJY6Y8t6o0mQFhwxqCdFqAI9S6cvdmPGsiCuJ26?=
 =?us-ascii?Q?IKbRoZJG9WIB1G1yKJZxcD8dbQo9ewcmlMgqewwwDEzGxnQMRArAwJINgrWQ?=
 =?us-ascii?Q?K/DYdrmjm86JQkzn7SrC/6arEJ0YA66gVmCsGkHheTA3zN0LHwTF9xgwCiCF?=
 =?us-ascii?Q?X91fb9BO63HuAzHuzi/W92X+qN5Hh9uOBZSKnksTfA9MXgv80Ig2U/jGieSd?=
 =?us-ascii?Q?pNQbGZIN+FoJCdiUpPyB6TCrq8T5dRqZ7eLEw1aQCbJAzCqrp9XtQqFFh47O?=
 =?us-ascii?Q?R6In3xhZUN7jZlpQnUyXIxEogqaxjznE/DIQSLm57eN+VEHWeNjADeURJrY5?=
 =?us-ascii?Q?l2DJuWVeJgENvDIYJ1jupD3IrtprHm7WGSQ0ePxo7R6Qh2Tu4fE2Yoj3N/pC?=
 =?us-ascii?Q?NsbZHGCYgEGcrU5AHyaUESlvYZXGrFWoDzoJyfNHxBrzy7w3XLTUTu6Ovr3j?=
 =?us-ascii?Q?TU06VaikLm6eUU5ednIobqHEcW2uwQuY49g4bfWrVRq6i9P8eBRTOwSrKTpM?=
 =?us-ascii?Q?EuBH9XMZGW8V/KvQ56b9eOQiQudfw1vEuSn+rXqka/xQymk6BQ+kTqy7z/KD?=
 =?us-ascii?Q?eCLP9IL75sxkS/0ezMLcOMB9MpFHYgRNDkpJeKjadQLCkkeIQflC/nwqqDGw?=
 =?us-ascii?Q?Rrqpbvym/6eSjnGA9LBvON8Le2+g32jEuRwq+yDvyVDAamnXXbvDIOt3i2az?=
 =?us-ascii?Q?A0E4YGNhUloHaDecIFAwv4z03S47MrxZjCp/O7W9ZG5y17r0apAePXtTlWIC?=
 =?us-ascii?Q?LwCcXluDF8O/0hDb85o5dUM6FSkI9VuxpJVhmsyIW1rPb0FxiY7kGiQA0bc5?=
 =?us-ascii?Q?14QoeXJ+6csL0Q8wayv0Ddd5j/UTtz+GTVOAXBoHysWS87QbyNbgOZFVgIh8?=
 =?us-ascii?Q?93kPMBZZ6dAiqve2RqiylXo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0636b1-6a24-4dc0-f770-08d9d9cc1eae
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 15:14:56.3630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsdBvqrKdCmB74pr90HGF318gTAE8upHT5ecgE74PWhhsrxMqomBrM+KXsYk1FQaAbEjhhKS3jVF5kUisYDntQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2844
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Dec 29, 2021 at 06:42:18PM +0100, Borislav Petkov wrote:
> On Tue, Dec 07, 2021 at 07:30:28PM +0000, Yazen Ghannam wrote:
> > Changes to the AMD Thresholding sysfs code prevents sysfs writes from
> > updating the underlying registers once CPU init is completed, i.e.
> > "threshold_banks" is set.
> > 
> > Allow the registers to be updated if the thresholding interface is
> > already initialized or if in the init path. Use the "set_lvt_off" value
> > to indicate if running in the init path, since this value is only set
> > during init.
> > 
> > Fixes: a037f3ca0ea0 ("x86/mce/amd: Make threshold bank setting hotplug robust")
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> We want that in stable, right?
>

Yes, thanks for catching that.
 
> > ---
> >  arch/x86/kernel/cpu/mce/amd.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> > index 2eadc7c4c902..408c9546ea0b 100644
> > --- a/arch/x86/kernel/cpu/mce/amd.c
> > +++ b/arch/x86/kernel/cpu/mce/amd.c
> > @@ -400,8 +400,12 @@ static void threshold_restart_bank(void *_tr)
> >  	struct thresh_restart *tr = _tr;
> >  	u32 hi, lo;
> >  
> > -	/* sysfs write might race against an offline operation */
> > -	if (this_cpu_read(threshold_banks))
> > +	/*
> > +	 * sysfs write might race against an offline operation.
> > +	 * Prevent register writes if threshold_banks are not set and this is
> > +	 * not called from the init path as indicated by "set_lvt_off".
> > +	 */
> 
> So if you convert this text into code, it would read like:
> 
> 	if (!this_cpu_read(threshold_banks) && !tr->set_lvt_off)
> 
> which is equivalent to:
> 
> > +	if (!(this_cpu_read(threshold_banks) || tr->set_lvt_off))
> 
> but easier to follow, methinks.
>

Sure, I'll make the change and send another version.

Thanks,
Yazen 
