Return-Path: <linux-edac+bounces-2733-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B944A9F593A
	for <lists+linux-edac@lfdr.de>; Tue, 17 Dec 2024 23:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5E71893976
	for <lists+linux-edac@lfdr.de>; Tue, 17 Dec 2024 21:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EFD1F9F6F;
	Tue, 17 Dec 2024 21:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dtLa0Xp5"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD91F9F6E;
	Tue, 17 Dec 2024 21:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472181; cv=fail; b=H4h5ZAJPnCNKI2iGZqR2vRfz+48a1nui6L8Md2kfHRb+uyplCGCGxLY37kBjPtdEQxB/mqW3fUXp9Q6E42w+LcY9CeWt0swbMXgBtmodYQDnVDVg+xGN2T0IreripDWymA5Ma4GfDMIA1PDRX16HxyEw+owigCFe8HEc4wTfO5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472181; c=relaxed/simple;
	bh=Phfjpo0r/YVfJj/iJonVrHZs6qovvBk64W3oWbEs0uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lbQBfhhzDke7fl9Etn/3GFcBMBAUZRNIAIeoLuLA3+WP9V8SABF1u7Sba3cRSl662jgt7kg9A9nwfx3/VTl/lJ7ViY0ceR3e71zvDJ3ew6583LwyR1PbPeX0iqDzY2KrSZilw0hJTWGSZEHRBEZtEuIG59ZP/TjX24JdSrAFm9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dtLa0Xp5 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Au9XAfhyt3yZdf6KWY65nopXuon7qpdcIitt3h+RbXo+iz5wqUiF4Bj1U9Jq+wD1Ao4mnUys4E2rIQAeKcq1SuBroUOreAVzmAJj9fJPa0KgVPAMaoSdnhx0CxWPr3M1tA5qggxLE+hOgj6rCNtKVDrFSUTyuuQA/UTCv8lcXN+j3ewCLIwFXQ4w7SD5ydN9xOAg5gecYbxLFLVNkdJDJInffQbcZVdFatkCwf+V5JZY0uO6+Cw9oLjCfXm/Qyw0c22JwAyiZmFgkplIJNFCbqYhhOS1fyWJmUsoq3gW/MNivWG9EqK8Zvf0NlqLIlBISFfGKBCqJ4X5D4Ha8EzdSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e42OWcUtf32mV1NC9oZshSC6pdfukkPqynwRKo7pWsw=;
 b=PUrx8mHB6DsuORRxjmfjkDHkBV30e+EUE8t5K+U/W+PD1NS70MrkzoOVmxY0yZl7nrOE0nUKLBxnuEdwv49cp1bTt6Z2a8j/S5GPC69aLEZnV8XAVBucI9R89+kozRQduT3ihIOM24KduP9J/00Cj3E5+OobMgYCAXMm1YtKKnYqAfoygtoJdgSnWrmRNaYAmODWm4OmYZmxoBSJQuAiOCK1z9CQ9OB/igLGLQk+GjLJ8AyrvEwD83v5121MvxplAacFpUvSl9PrxSt3xcNkOd+bLJiQIyoxR/1ptOZ9VZ1TUykLgUkmuFgvXGoEPf/8HCzVlWY/vf8MHpaW8rw3Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e42OWcUtf32mV1NC9oZshSC6pdfukkPqynwRKo7pWsw=;
 b=dtLa0Xp54RbpVU3M7YWmX7uSGUh91u9xKe8jagG6l7dRrGyIqmblQ2A17QI6azolxt2mQG8/5x0l6WlmkOdA5cREXid3cg8v1IdPwMjfNohU836g7fFlv9ODJxYsgu7nJLm7QfoLuesQJtjw/Sxthz+jX4a0clCMB7CxBo6sj2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 21:49:34 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 21:49:34 +0000
Date: Tue, 17 Dec 2024 16:49:29 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>, Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 0/3] PCI: Add support for logging Flit Mode TLPs (PCIe6)
Message-ID: <20241217214929.GA1121691@yaz-khff2.amd.com>
References: <20240614150921.29724-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614150921.29724-1-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: BN1PR12CA0005.namprd12.prod.outlook.com
 (2603:10b6:408:e1::10) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e1db478-78b3-46bd-a0ce-08dd1ee4b1bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?ScysRxDVDnxPyxTdWS6oKCSyBQ1JQ6TMatembJGOMmsn1H/vdsAn3G8hyg?=
 =?iso-8859-1?Q?ztWtVyY9jvFqArkAjckvKPbv/7tvKngBP+34ysh0oYs1vPHxqcg7rCHSSS?=
 =?iso-8859-1?Q?WijoPQmvGCLGHxte6oGx1eipPpoAUlbAA8uWbKoxi7UlD8QYUnsmCZG+RT?=
 =?iso-8859-1?Q?CGgBkcxTJTKOauxhhAQKDUbg7f5aA4oYEHmVGyKJQzGDR1+ZWDX0WqnOV5?=
 =?iso-8859-1?Q?dB4WSgMzV0QNW11568Q0dKE3BUk1mXGBsS2dKQtKqdBVuvJxYO6CKnCzAw?=
 =?iso-8859-1?Q?pCqzXmlVKv8kd6YwdTAs6Sw6d9eVoD00VeZ0SR9JAqalwKraUSXmW3qCmy?=
 =?iso-8859-1?Q?6YH8BfEvDQP0aqYnA2oTol/haH2KVSVCV9gPYPaMRlHq57//KPC11rgJwW?=
 =?iso-8859-1?Q?UG7Qlrxf+Pcf2lpzzKeWhROJvMil0WbGMbT2DGbwt2K58bxtwkTJ4svOlV?=
 =?iso-8859-1?Q?auKeRnxl/EYJkoRdQn+Ko/TyzzI4mKRkcdAYmEytUotNpsk7esqoB1Dtmv?=
 =?iso-8859-1?Q?zr6FBrEAJfCuxQYNxm7qFdXecCKSIKP3+t9qHZF9MWhu8htn7sQWh04mx/?=
 =?iso-8859-1?Q?2bZJ1+JpI9muQR9sKXipeQDotU8/IJSLnqnHHiTZ0guLExJXVNJFCHPuzv?=
 =?iso-8859-1?Q?RFvDmovGRZcoLMtt95bwSHDSWEXa7rc/ZR/menlTF4hV2dEkh/2WdV2ItG?=
 =?iso-8859-1?Q?5iDbVhwno7P+wrfYfruByr1nYGTMphvz7mkd4iYrPt+M0LfQ79m3jcix1E?=
 =?iso-8859-1?Q?CWcVaJnOywuxblC0gB2l1QE2TUjnB5toTUt3g1gVwGanIf6akmLq3oldVb?=
 =?iso-8859-1?Q?zNy8T/5rrupAF5XJwCMqLse3SFMRSoeCwvRMLeEFT4RCZHaWIT7Gct8bnD?=
 =?iso-8859-1?Q?LXJunRjBoeaX3CSc+7aU4ZrD6poLNfU7i0YYuFCvO/dBsnLKI5Fq0zWEa9?=
 =?iso-8859-1?Q?MrDKunUs9Vy9r1D83Muhw/MiBvrUdnLTuP+nNBIekLBH4WVw8bXS2mulWp?=
 =?iso-8859-1?Q?tueP8k8zQSHdZRtEaGHvwaFxkKk5Fu+wpG2rDkoEEVLmKQl2y9FLUcED7M?=
 =?iso-8859-1?Q?QKhL2LYd272HFiZZOgRiBSgr/XfK+m6cUSdyzoRyqWCVSs+vMyYN7+mtjd?=
 =?iso-8859-1?Q?ytdlXbJem7tl8m6B0V+GHg/XNFruw8+UT+BV9yNDsqZwurvEvTrBZhRjM7?=
 =?iso-8859-1?Q?6Cpk4wkGt+Sb1Mh1iJ/kXOzbhdAU44Rn/eBBohI8hSSkyW5Rgmd+B56J3D?=
 =?iso-8859-1?Q?QY/7jp/55MECuF2WUqDoA7v1X5E4giix7T8nW2Rnta0/UhbxeU5ceeSFTj?=
 =?iso-8859-1?Q?BlmrWIWoCgMl+prFlQbkCK7nhOyam/8l31TQQFz2R9A8hNZCq7m5GgZ+Wq?=
 =?iso-8859-1?Q?DDiHFwuakB6vqetnZklTKx1vwBScHianLZJ/nXdA9iSqm7NwLeSXv1+zjm?=
 =?iso-8859-1?Q?UhPyX5RZu3LL3o3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?no0DnCSzBzdBW6tuuIp7GMeIGXJ6dPnznTw/SH3Esy4P9DOVJFsyFusdP4?=
 =?iso-8859-1?Q?SS0eb9wbpV8G3RltWeCQoMIj3rpKQMLW5sXqMz+QjWJenVrts8IxvJb0AU?=
 =?iso-8859-1?Q?GZeqfAWy1UfVHsFv7zbTmJF0xy79geE6TJ0QTO3NadpunhDz3zqJ4/YIlz?=
 =?iso-8859-1?Q?CBHKngQH+VCm9yRkvnkUPn/v6OPmE1q4jJobyiyxv6sEJ8/iLCOJQfjT+n?=
 =?iso-8859-1?Q?M88DsW5soTic7DS5fS71UgpMDdBmB7yazqhaIh4n9Zn6DrsyrNK3pFMy5Z?=
 =?iso-8859-1?Q?NtTWVHjmebcOBwH+qxjFWswRspbXRtTqK3jd29ezgXD7t1vwbSgGWAqVpg?=
 =?iso-8859-1?Q?DqKEArgl8apl4XIvuHKwi/kVAfc32stpnB8l1sT3W7VwnicWM/oodGWFV9?=
 =?iso-8859-1?Q?MMXsmcrUwXpi+rRWaoBEqGZr6aI+LTDesoWEUFqBhPY0stkrBGyaferNgP?=
 =?iso-8859-1?Q?ZhqloPG9d179i0xjw/pyyl/5188tBzb/Bed248dkypB+YTKEr5PXXyjBLC?=
 =?iso-8859-1?Q?2fl88kyFrFsZC/r4WKXM0wQ3ZgGkmVhkYQOui7oyvn8M2rCkYWOinb4Ns6?=
 =?iso-8859-1?Q?m7350Ujn4sIoN3GbQGWSXJxJ2XjWzrLheifROR5wnQ4QNS8EljUnk5+h3o?=
 =?iso-8859-1?Q?IRxE0Gwry9VhWpL/TzxmDwExAhpnbeMGlZr/Qwt7eBhmaiTUMUfNYD2TiV?=
 =?iso-8859-1?Q?6ytIHU4dOedHElLNs68OU4Im4xe4//cgMUkRHWV+GK/wFv+4cOb9AlNLMj?=
 =?iso-8859-1?Q?dTwE/xLTNGpa6QNyFc3PQtLVFfQRfWs5OaJRFPxZ4ChIlm9Hs0OsTuBx9g?=
 =?iso-8859-1?Q?L5mYvtgTbYrWKfxiMovBFPIGPWuUdruDFWgrxS2AeY4Q1xnoMOTINP0b8/?=
 =?iso-8859-1?Q?xKFKEqiBvjKBxsLwdyNLBHFulr69E0hHei7Y6he7vOKhDFKFXdzsZHSvOM?=
 =?iso-8859-1?Q?8pOeXgbtaHV6xZ9TVBmctVOmBL/sffCw13Rb1fUOCyZyl7bWO27GDnS4lI?=
 =?iso-8859-1?Q?cfMqnbOSIbILc+PZIMG68jixBmcuTk38o2mrdtwvUfrOLW85/W19LzYbgv?=
 =?iso-8859-1?Q?lCZH7yp8ecZO2xvVmErg7iVgSMj0m+JkKqAMAbR5j/D1/XPb8EJnOF1EYr?=
 =?iso-8859-1?Q?AknCz8qJvnaCBMDem544rDPpn4iHCtrOkNi50pWLKCpwC3yIboaOQHa3IU?=
 =?iso-8859-1?Q?7BSHtSouonGUwrkJD5/2gSYxq3B613zf/yYkpeRraojT3Rpt+BCJ27j1Sz?=
 =?iso-8859-1?Q?2csyxJ3effgYE5BhaE/NwHchxgrUNurbItyEamJ7QANeJ5gy71a89RkT4g?=
 =?iso-8859-1?Q?8xBeKqAyKNHfa6x7n3XpYalQTQlIJ9F3EDpRzskf61ldAAtsfvTb+FQ/Vy?=
 =?iso-8859-1?Q?L4bdQ1o2RLpvhA6R/0m5nhnemiq4WAC18z4ZHTCTq6aSG6pdIY0lV+iq8x?=
 =?iso-8859-1?Q?QvO8nV8qDmWGe9hFgzTFbLWyxjy2VPMR1HEXNZ701GxGdDCe33nv6Hea6k?=
 =?iso-8859-1?Q?1lTxgRyaILgm1X31NQYX0l/ISpq3TdNrqAUlMfmAuMvWaltyzx4bFRyrdO?=
 =?iso-8859-1?Q?1/SEb9AApepqvsQklAYa+gflHo60ZCA72z1445TbjGb2GNGyXVyrauMMco?=
 =?iso-8859-1?Q?Xi+/S4vgQ/8nYeB1Fq8iImVZpLPPh/SZwb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1db478-78b3-46bd-a0ce-08dd1ee4b1bd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 21:49:34.1487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JiJwg1tmUw8+BFrik3ldc+9rnwOGVDoPesitfuqWowWk8E+AyN7MF5/SXN4aGJtUrAN8h7MnjZGxKZi6m/eaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092

On Fri, Jun 14, 2024 at 06:09:18PM +0300, Ilpo J�rvinen wrote:
> This series adds support for Flit Mode (PCIe6). The series is built on
> top of the TLP Logging refactoring series:
> 
>   https://lore.kernel.org/linux-pci/20240514113109.6690-1-ilpo.jarvinen@linux.intel.com/
> 
> Important note to maintainer: The series carries
> pcie_update_link_speed() refactoring change that is almost identical
> with a patch in the PCIe BW controller series. The patch itself is
> basically the same but the context has minor difference. This will need
> to be considered if applying both series within the same kernel cycle.
> 
> Ilpo J�rvinen (3):
>   PCI: Refactor pcie_update_link_speed()
>   PCI: Track Flit Mode Status & print it with link status
>   PCI: Handle TLP Log in Flit mode
> 
>  drivers/pci/hotplug/pciehp_hpc.c |  5 +--
>  drivers/pci/pci.c                | 12 ++++---
>  drivers/pci/pci.h                | 13 ++++++--
>  drivers/pci/pcie/aer.c           |  4 ++-
>  drivers/pci/pcie/dpc.c           | 23 ++++++++++---
>  drivers/pci/pcie/tlp.c           | 57 ++++++++++++++++++++++----------
>  drivers/pci/probe.c              | 13 +++++---
>  include/linux/aer.h              | 13 ++++++--
>  include/linux/pci.h              |  1 +
>  include/ras/ras_event.h          | 12 +++----
>  include/uapi/linux/pci_regs.h    |  6 +++-
>  11 files changed, 112 insertions(+), 47 deletions(-)
> 
> -- 
> 

Hi Ilpo, et al.,

Is there any new development on this feature? Or is it on hold while any
spec oversights are worked out in the PCI-SIG?

Thanks,
Yazen

