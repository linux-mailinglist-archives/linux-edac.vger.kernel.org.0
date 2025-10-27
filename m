Return-Path: <linux-edac+bounces-5200-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEDFC0E4AD
	for <lists+linux-edac@lfdr.de>; Mon, 27 Oct 2025 15:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6380E34E668
	for <lists+linux-edac@lfdr.de>; Mon, 27 Oct 2025 14:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF6B2BE7B4;
	Mon, 27 Oct 2025 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EBthcE9H"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013017.outbound.protection.outlook.com [40.93.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81EA1758B;
	Mon, 27 Oct 2025 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574308; cv=fail; b=ORqvUQx45R5HCYvMzz22v+pNipTNXlPz/plMXsHsz7tNCtK3dvOCIcUwYbrnN5DSp3LA5IwWcx8ve323f4R34Nd5I2760a9RBLRGefDuZcXtjLmZRRqtIati6zBx+J3kDVdaQcuKOyE5Qbk2/KzGVqEQs4Wjtnc4YMD79r8nJoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574308; c=relaxed/simple;
	bh=9HqOHstqV/lJYq2LVfW6Tj5kXQgl0Ypb61hXF9/cGvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eQ/bgvSV3OGpONsimpE0v5LMfDCZIAQI8i4UhoRmNbgHz8tlyY8O2tVNfYgTk8pOpPDmgu/8wiHL1AMN2ycMv29mFKxByST0Sr0Kws1n+LnLJETCmBpxDuyYMXZatAWAVytdqVW7kEBu1/G5/rqS04Y6caBZThWGT2MaPq7zLx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EBthcE9H; arc=fail smtp.client-ip=40.93.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHU3jHSIugseCutFlWlD+0aq3oA890pJd1wSBnUr2pvdG+tCkURu54d/qv/nUUFTHbDbvZMcqLDt7RjwHx9WWd3D5/hP4uedQuIzNwZtrdIoEkUdvc6P13CA09efGkbiAsRPrNJ4xCrmvbDytowO/dKKu9spMUpcXLhInE5jCuu9KMQKICJGCeNLDNeKk2UbWyMjQjzKL+XkSH3Ko+uspCn0wCQ6xtbX5TKtCcYy8AGOePJ0mONFT8GPUeVnBIBJUsYixHj65132nYpOpxWUQyBkvZ0u7kAeJSGrJWvDuK5lnAzYhiEdZFQeldShTwxYBos8jjOeLAb5xrT5QqGQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGT3RDaMQSnfx0U4HSCJay4jn5hXI07+U1rgsga0KSw=;
 b=HBasAAVhjC9tsQyoeD+1Ym6s02qT0gFIUiF8x4Dx4Ofr4viYRk/GjrO8ET5Wyvq4ZozDjVjfJOCX91PU3zgsYzXQFvuQLLfKvEEVBNXdkklMTYCxho+i1ZTvLVLbgrVrB13Tz1ZCuhsmUWK8MWU0JMWwP88W6TFcAm9VnUkZarcICZeE5cACY9Kwosc8Rm6AMswnFoX249V2Fqfut2+1XGA8I4NYw3BNoMJxIU72atuMcZ4ZdU4sr3kjp4vPd1nQR3rraa3jCZBjVKS75Z78ZsTkZdty1AYpCCZpRYjaSHfjH8DuE3D8L5HiLV9Q6wfUq+aKDBanvaNzF/3Vu5fF2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGT3RDaMQSnfx0U4HSCJay4jn5hXI07+U1rgsga0KSw=;
 b=EBthcE9HCUYJUGjXtRK2HSaVBmyqCDI181AyiuAr6F+kag0PJtuzOeHGS8hUcemN2/s9EiWbtHjQtX6lfoSlFO/NPrjF7SEUj+7uvro/Kr1bziQd2E7/g1xwdDplBPO5SSKA7vQioCBM1F9rDkvPVUOXatqOJ4tlnsEbeSsVVOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SA1PR12MB5638.namprd12.prod.outlook.com (2603:10b6:806:229::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 14:11:44 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 14:11:43 +0000
Date: Mon, 27 Oct 2025 10:11:39 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Bert Karwatzki <spasswolf@web.de>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 2/8] x86/mce: Unify AMD DFR handler with MCA Polling
Message-ID: <20251027141139.GA51741@yaz-khff2.amd.com>
References: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
 <20251016-wip-mca-updates-v7-2-5c139a4062cb@amd.com>
 <20251024150333.GSaPuVRQYxH92zyrmO@fat_crate.local>
 <20251024203012.GA251815@yaz-khff2.amd.com>
 <20251024212723.GGaPvvO3l2OlUEG7Xn@fat_crate.local>
 <20251025150304.GXaPzmqFawI0NrCC-0@fat_crate.local>
 <20251027133542.GA8279@yaz-khff2.amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027133542.GA8279@yaz-khff2.amd.com>
X-ClientProxiedBy: BN9PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:408:fe::26) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SA1PR12MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: ac580a29-2c8b-4863-d02c-08de1562c1b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?00QM+K2NHUoMA3RvDxZRkVOtRfjicMw6NYdJQujtPhkIj/yx94dVmFOYIEsD?=
 =?us-ascii?Q?v+wfGyJwF/nOwT9sP/SivE6o8SpsnsEbCe23IPYtPmg5j2NhDXOwTgcWnb9c?=
 =?us-ascii?Q?y+DKcT4r/ZkpNzTtChwRjVoeTEkBM6BxTifk4i+steJhC2JxSfHqxUC5Ftia?=
 =?us-ascii?Q?9hPl2sQgNEAybYSV+DwFP8+bA7q1ZrMydPw0RDGhLeps2Qc+eHhO2/OWFj50?=
 =?us-ascii?Q?QRtRop3QE3FuKX7q7H/F1HhSgHEhq1VWwzqHl458w5NBXNdpIxkx5l2wVYO0?=
 =?us-ascii?Q?NxcdeUa8a/G/ToLEjJQvBm4wyB9QgoJ8yCVzCJgKyLdBceWZNrhyfuAph9mL?=
 =?us-ascii?Q?QjkcZFAjSHAJ9G5iZWle3cOn6iCi1vWR6LrgbQAdniPrO4roj+TrqVY2YoAg?=
 =?us-ascii?Q?Bk4z98YqQePTxNmlZHxFYFLZRNu8XTWHIC+9ZM7KFC3kSkr0JYfyFENMLEVx?=
 =?us-ascii?Q?3WThhyad6z19nNnQmG5KRjQgn5338YC5dcygjincBWYqlLQY+qJWfKnHmwhw?=
 =?us-ascii?Q?Rw+YlUPi18d+2lt7v9xND5ADn0u77UZuV6wb53P9FLKzsMtQcqLz65j1fdRG?=
 =?us-ascii?Q?yVf1bDTM5dTN3BjVcm+cBaN6prTnq3HUAVAHXIyyA4ujpxNqCAl9GU2KLZgI?=
 =?us-ascii?Q?VgbL+AIwCCwP/+tJUScIL/FxdWhWCsMq8c0KR239ku3DI0eecTb7Kz19TMb7?=
 =?us-ascii?Q?f1Y17fnh32cjDGM+qWo6GKuR7FFD3sXuJW+yWteuNlECBKcJKhGaLzfJyxEr?=
 =?us-ascii?Q?BNIARSpeB0Mn9vYWhFy8PxGZmkHQAgzlsHJr3xyciXqA8Rc2o8Q2gKX4u/NQ?=
 =?us-ascii?Q?pxW5bRdknSoHQH/maZuiOoBLR+9MMwf56S/Xp0f1IAD9BwidyEwAbDCQ4aiO?=
 =?us-ascii?Q?Yawpe7JnuGqeHD+zclUpX1gBiUdVMFxb2Uz4O0JsE96CO7YNuC4jdkpZar3l?=
 =?us-ascii?Q?Ty0qeYHcMBcqKS4Ppn75JszJu9JsPG+MdvkkDO1pWBSTKH9SOs3Z6IQTXmUX?=
 =?us-ascii?Q?g89/TuEnJ7loNYL1mD0Lxqu9O41BUbgIV3YCPE3AwoM0mJzAJEfLr/hV5K0O?=
 =?us-ascii?Q?isbdve1uPg0r+xDsHnuK7dO+HKOLH9TuwZ94cGbwhczr0ChyPROAUE7Wxc/O?=
 =?us-ascii?Q?rfa51fJc9vrio75N9DSiPKsJe2CfuJfYmqouagMC31b7Qpgoxx+T0YFSEDoI?=
 =?us-ascii?Q?5haF9IjUlzUxRrCuoKsNtooJ0ROm77QNv+IaZbVemVvY9LzjTqYr7Qp/qU73?=
 =?us-ascii?Q?Zkd/mtF9M2uXfoXtJMqpmE+IqGV0fYUJOYAehIcFyASDRdmE4UtlJIevn0NS?=
 =?us-ascii?Q?oBoRghKaDQobg/5vXi/YmUNqkpuszRUX+5KZB8xN5epN9L/qDR+fSClq7iAy?=
 =?us-ascii?Q?8nA3OMYxN4qHV7v+fsAvc0hDFsvVlHIH542PcvxxSVyLzdHg5yAFrgSVGRWS?=
 =?us-ascii?Q?oKqQcSMuoo0Zmt3FfYA9kqQ+tfbZHEfZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WX1wK5cfSQduwm3qIgtxL3PzmZ2O1QwlssNVWNcSRxTL+1nfr/ZerbVNxPGw?=
 =?us-ascii?Q?g3R1m2/jKuNcrjnagTMqg7KTw+dISf0jeI1S/C3nfNdaNeSYlirSycQDNmGj?=
 =?us-ascii?Q?Pgf9Rxxl9ClvmjKOdjDTstMwUAiYKk1g4CntpF/PskP199w+qQKZLPD2F66H?=
 =?us-ascii?Q?B5QW2gXkgCcS6jA0a76r778N4hdh0gXjVja8hyZMuh5L+GLpKLOruqrWcDcP?=
 =?us-ascii?Q?wUpCZJxD8Z/XdeIgSvd349NkZCPLW7n+sXRI0qGvndRwuudAdFuZ6zGQr7Wk?=
 =?us-ascii?Q?yi9y7EiWzhxW4h4drwv1nzbVQxH98xVaFUCyktic1ihxIRNSWfSIf23aR1ZZ?=
 =?us-ascii?Q?MKYnBvoKACMC9kh3bRx2wpRjXhEMzLT5mNKGRv8IrehM+FMBEmFSgR+wHXZy?=
 =?us-ascii?Q?FXAGCcGuT5TKKQuYen/SBi5+ZJiFbh8bQp5DfY4iBlGFaln1JjzVtAm2IJJB?=
 =?us-ascii?Q?sice6mQE963VOQBqN9jyjg0F3Hy4eEsTWzOg4omft95FjhANfx9YYCJtyVpk?=
 =?us-ascii?Q?Py1qYt5L1+bjhEQb6NjI0nHi58LTM5zjZ5nHJ2FpD7Aa845NmEqCiJxAOOm4?=
 =?us-ascii?Q?atskyO6cU2EgqF1MDnCqhGT+XqD3W5npVf8avkfl2iON7NYn5mLeqY8El+Jf?=
 =?us-ascii?Q?gtWk3NAydSEmrtWzm0S6WadKoXyUy9IU++AJNc05O+86Hk1x3zCisVmcowVy?=
 =?us-ascii?Q?gHkJgyUzll48Bl9jBtKSNV336ZcM7yw9hmN2u4rsmJVyXpLUiO2EnrD7vk01?=
 =?us-ascii?Q?SbTevxMgKd933l2rE6GK0PDRYKp4xBYV/c6gdHe41KGPgJD/gHAih6vtPeFw?=
 =?us-ascii?Q?6LUXPQ5UA3/eLQQhspu2NMwGlInYcYOL1Vvzx8JF0MBWzgQFxbppUt658jry?=
 =?us-ascii?Q?lCqrJquRN9tYqSo5V/ZE76xx56FSsPEvi/IO6Jl64ctm1Jbdx7//j36oSC7A?=
 =?us-ascii?Q?/jYHtzQ0LZep+tswaZwc1mMxsMezMJGyHXHLgua6zcF2xiSKMMvjk8JwEFp5?=
 =?us-ascii?Q?XykJe13Q5iyPtWgl+RGJcrpJ88eWnKCjip3/FlXh6LxCD1ZBxn1XzuCh0jgJ?=
 =?us-ascii?Q?7+1HIFe5qmo12+lwWZgZWu9rdx+YnDplsvloQMD2CZ0ktGe3q292Ko06YMcg?=
 =?us-ascii?Q?eTePXxOxU9CClRGClOsG7uLfQvDxiwcAe81y1IgVPiXdTJKiWLkXQ44O2SmC?=
 =?us-ascii?Q?sXGyAB9z2aZPGD7cCCs1ln70mIxmK/IoZo66xblFRQV9v6gE/pR/aUQqCQXR?=
 =?us-ascii?Q?LXXpKJlFZ33FnkPVGtt7Hxj36AakAqq4FQbVjHBP4LUzAyYq067IP8h3VdMa?=
 =?us-ascii?Q?9huTEh7BCrnnXHS9u6NaBhL0eQBvCy56cA7WxklPZ5SUEtNJyLg0W/1XPQaX?=
 =?us-ascii?Q?tcvGJ9MxBh/FjBcHoGuMQYXpd2z+csmtDrxaT7wxvFoBjpVwIKjQnpkYjd7L?=
 =?us-ascii?Q?gjFf0PDjSpR0TcozKL1LVM9h4A5ZyxfnZD706i96qWe8Ow8o2H1ePSieujXC?=
 =?us-ascii?Q?qPGGXZ1uImXbK6TwT5gpZKAz7Go/+lVbAvZs/JFNN1FyDg9RLkFvXd1a+bDI?=
 =?us-ascii?Q?eNqOygfBC09E5Fbd+W0kqTEpRUi/nWC7Pm6tKw+u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac580a29-2c8b-4863-d02c-08de1562c1b9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 14:11:43.7061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaI3pHtGDFgtV49HmApFrUucArsLWWXX0wDhfObt8Q1gjq0zciLScs8Chgq1X5sHp2dPfD/1M2mgfuGwPMeNPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5638

On Mon, Oct 27, 2025 at 09:35:42AM -0400, Yazen Ghannam wrote:
> On Sat, Oct 25, 2025 at 05:03:04PM +0200, Borislav Petkov wrote:
> > On Fri, Oct 24, 2025 at 11:27:23PM +0200, Borislav Petkov wrote:
> > > On Fri, Oct 24, 2025 at 04:30:12PM -0400, Yazen Ghannam wrote:
> > > > Should I send another revision?
> > > 
> > > Nah, I'm not done simplifying this yet. :-P
> > 
> > Yeah, no, looks ok now:
> > 

Here's another fixup. I also simplified the function parameters and
tweaked the code comments.

Thanks,
Yazen

---
 arch/x86/kernel/cpu/mce/core.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7be062429ce3..eaee48b8b339 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -726,21 +726,18 @@ DEFINE_PER_CPU(unsigned, mce_poll_count);
  * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, and
  *    log it.
  */
-static bool smca_should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
+static bool smca_should_log_poll_error(struct mce *m)
 {
-	struct mce *m = &err->m;
-
 	/*
-	 * If the MCA_STATUS register has a deferred error, then continue using it as
-	 * the status register.
-	 *
-	 * MCA_DESTAT will be cleared at the end of the handler.
+	 * If MCA_STATUS happens to have a deferred error, then MCA_DESTAT will
+	 * be cleared at the end of the handler.
 	 */
-	if ((m->status & MCI_STATUS_VAL) && (m->status & MCI_STATUS_DEFERRED))
+	if (m->status & MCI_STATUS_VAL)
 		return true;
 
 	/*
-	 * If the MCA_DESTAT register has a deferred error, then use it instead.
+	 * Use the MCA_DESTAT register if it has a deferred error. The redundant
+	 * status bit check is to filter out any bogus errors.
 	 *
 	 * MCA_STATUS will not be cleared at the end of the handler.
 	 */
@@ -780,7 +777,7 @@ static bool should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
 	struct mce *m = &err->m;
 
 	if (mce_flags.smca)
-		return smca_should_log_poll_error(flags, err);
+		return smca_should_log_poll_error(m);
 
 	/* If this entry is not valid, ignore it. */
 	if (!(m->status & MCI_STATUS_VAL))
-- 
2.51.1


