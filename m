Return-Path: <linux-edac+bounces-3909-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E04FBAB6E37
	for <lists+linux-edac@lfdr.de>; Wed, 14 May 2025 16:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658161BA2172
	for <lists+linux-edac@lfdr.de>; Wed, 14 May 2025 14:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF851A3BD8;
	Wed, 14 May 2025 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eq8+4HDK"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C698E1624E9;
	Wed, 14 May 2025 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747233265; cv=fail; b=pDJjlmf4hDtk5UD3umwq857sg8iddPFsiUQp+EhCR3DdCW1fEL+zidtPV/2bTT5rZam7SUVCg+I0Nk07ariuBLlLAJic9U0gqZTs+/+V29YR223qNcW3+dfpKBi7hd8OVnkyCujiImHy+5++LWb99/HsmHcLXTno7nVC41L9iuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747233265; c=relaxed/simple;
	bh=50qeZ4z6aS1Sa2jMO+gSZlhNi7mGxmXeYiHbdxJn1sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tv+hvwwnc5wcde/21Ye2K3vmSiDFGnUJYKwtLMYwdScrBAHDBzx356UOwYgHfpJO7UxpNQN+KQFCVkWXoJWr3tyPr1TJzb+fm4+RCEuYm5+5t9k0jbrDs4Tdt5APsat9S5XKq8esWYi3wV4FbSEJUPfgDELUT/MNglZp2j0wZvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eq8+4HDK; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqBI49oviL2DLlbNKjJ8fGve4wmGOpbVCNatm6Hu/yw3sHTDzOdmnCSxwAqOIoHB7u4qgJ9XmYqiEYvxN/7WYEEOWxtVZGSUmwr/wJOZIINBQA9lV/uXluG8KkVs6YLOZph+ejc7u6Y7VSDLF3y/69+6Vgej32wRe7pTqchVUmO5/U1Dm/y8fCjTM3VRuUHOuleSG+PNXxrPnfnnh6Xyu4qGXDx941nsYjMGY6w2SMUlPgKpwf3jArFXG67vlTNxny/brXZgEuJ2bN82ZvqknpqiEipXMaaanUP6NCFFgGm4ah5Kgffk/9/2D1Zv2h51EhkeVA6er+/NnAUf5Iqg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rF51paxi3wOBXhznCx/8Emo8h1bLugA/AVGURCa7bao=;
 b=CqBq3CiIgMib/9B5+Gu6SvZ594XjI34QGAWJQ+4pNFWv0YoSIZJJ8RAcl3p6sHk7nWOlBNJ7zGAu8HjD2HRbkWYHiSENBEF7932cRD7WU2IuScTwhOPnO57FGMKqBvopwW5os4VCKm7kiBdTAPrzLxhKL29IwvQkuPQEfxZIJuNY5AdNsc95p+KIxFsKC2sq98nbU2VGiLWPhm5P/Hc1boj3p3Fka3EMnCPPxw6P9VghmoArU3+ZoUaZntV4AA436bxqSV42ZRQc92GO1gtHzk5fGUvkX5/Av9pYTnZKjm8uKYtco9bw2q/mIQAfVZF23W1JxmkqXDg29KwhOFfGYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rF51paxi3wOBXhznCx/8Emo8h1bLugA/AVGURCa7bao=;
 b=eq8+4HDKBhQwhhb4esA8k3JTYRWRTjxwS7KFFbVsP5N0bW7xYC3eHB4Ber3zhK5f/MLmL99ynYuFmF45nqB/0cRmsPO3L2ulIlBhzYucaxAveCzpSh86O1VwATn4sZOAiyLg1J/X8Es1UQ6scW+PQ6XaTVSj6iblWaxszMQMobQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.31; Wed, 14 May 2025 14:34:20 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 14:34:20 +0000
Date: Wed, 14 May 2025 10:34:16 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>,
	"Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 17/17] x86/mce: Restore poll settings after storm
 subsides
Message-ID: <20250514143416.GA597208@yaz-khff2.amd.com>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-17-8ffd9eb4aa56@amd.com>
 <20250512074616.GSaCGnSJbBpToh2VM6@fat_crate.local>
 <20250512154315.GC2355@yaz-khff2.amd.com>
 <20250513175543.GGaCOHn26isB18J9ig@fat_crate.local>
 <20250513210640.GA515295@yaz-khff2.amd.com>
 <SJ1PR11MB6083BB314BDEDB397861C845FC96A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083BB314BDEDB397861C845FC96A@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0277.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::12) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: eabc9a2a-e031-4788-3acf-08dd92f469e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h0r3IDRawXVmwCIhqRZCLwcpna1RN/GeDxdxrXXopD3f5ic7qqAKeOy7ArlO?=
 =?us-ascii?Q?ZbcB9X/nKJofPzUNqab5OuwI4FP671X3z44NM5YBRjvYXZMAt8x0lJi8F6BJ?=
 =?us-ascii?Q?BDKCaiP2xKXW2XLXqMWRh7xVnfGRWx6ZTUmyz8kDy7npwP8nQGF3RU6/1i1X?=
 =?us-ascii?Q?gUvYt1KEhdkf8D0KMDbBKh1W3d8Adp+ABkfda6i+t/P1Yg5zZRx0ydYKbIjN?=
 =?us-ascii?Q?+YgvGMiq5/4wJFaRrKm47AtvURYaTGkigGhBYaynhoGU0UO6QZaI/2U18npn?=
 =?us-ascii?Q?y1pEaqlSkxkOcCm3p0dvZCT+p26H+ds+M+ZNFdRefC8FIxWbUICOve5Uxsp6?=
 =?us-ascii?Q?Sv9GvdYfJ8Lzarh4Iy0HdSu6n65w9l1lPGxxo22M2066aBq7g0GYt3By9UoF?=
 =?us-ascii?Q?wdB2+4qmzaoSD3pYw8EMnj2wWNSsTXtotebiWrB82h1fJi56+fAa8HJyqDkI?=
 =?us-ascii?Q?OidZoVInpvy90zs8p/bhBkmpRCvRPfDenjRveA88AxKpTUp34dvwk1RdvK+A?=
 =?us-ascii?Q?r5Pl87cMjOoc/4/iYZe/13lwucmFKOq355cVuUExx+xsaT+hBVWj/aClBfTq?=
 =?us-ascii?Q?K5130vPgtTsJ9P4wTh0H2+PkLK7W8hoB5Sg/uHVCMY8DQNdVfgEZG1hL1ixv?=
 =?us-ascii?Q?CoAE3WcOm7pv2V1rWjxM2LJWvc9Hgd6kDlUac52WThX2o1qzFYn5Z0sx2a8Z?=
 =?us-ascii?Q?ANm3rD64JPe/SZaGdWA9961gNgxJv/Em9KGQKDUqpFQKf8Np58hfAMun7msL?=
 =?us-ascii?Q?fYFfvDVXonTtmKFS0fno9gE7BHkj44JPMdeDZeVFEpF0zSJyX6Bk9qIb6REl?=
 =?us-ascii?Q?jFS/raFOuRwsRbf3wz1Gv50zqB25KClnyI0LE3KbVX5a7a73912G69uBCwL3?=
 =?us-ascii?Q?iZOZvn6UUD4iFIIOELOblw2dpIqWlW2xU5JVZykah9mZ+P0jNrB31ffiADoF?=
 =?us-ascii?Q?1I9m8lnClXc4L+yQ+fatwGPJN/S8eLWOpkbTwZX1IUD5FageA4MgrfKsmp5s?=
 =?us-ascii?Q?wI5VbDDmOHgFgTNYRP309VdWddsgwWTs95BTN538XyfVjnus4qmXisD1en+y?=
 =?us-ascii?Q?AmFKhE+fYTpjDCPXkCYskuwJxLYTeMESN1Sck7Afme9/YaQbzJ3hwvltSSBu?=
 =?us-ascii?Q?pb+nXkjRytbiOpDGA/MLqiTIjQgZzk+fAjswSYOsBuV5o0dkd0nGjvFriTLb?=
 =?us-ascii?Q?YHavD5mbFZnCQ5brciptkSIMex+Moqo7h8Ta0jMyCsNUgIHXrFCLuAOG7UkU?=
 =?us-ascii?Q?XaEiICCYSrsD9/LfTVQgSDoo3HSYLAtPn/C5pNXM0Iayftn+4Q0JiFSK2YYw?=
 =?us-ascii?Q?Y5aYuWs44Pb9UPZ1qRKcre5E7fWrdGN4D/jNiJetgxOuDqXuSJ0GWFswsymG?=
 =?us-ascii?Q?pfaFbM1/nPxW1RDRJ7xmqTZJT2sZO6MoFP56ZcVTVMmQ2r/cG5s7x7R2lXEh?=
 =?us-ascii?Q?srlvh5aDDrs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UdH9J+uzUWHtiNnH/Rt7whcBnE0o9Yz8oH4GVS9SjntASmwOMsif1teYgrGX?=
 =?us-ascii?Q?aWR79U92mAkaX6KFshK4SgHhuALScJQmNOCiyHlxCiWIr3A0WAO25tGHRsr/?=
 =?us-ascii?Q?6Lui6L/EvbU/jQV8zcBbzd8W3AZ2awKZbd3WEKH3gLyZAFhnLCQD6Exp65uD?=
 =?us-ascii?Q?cSJCx47Q/8y6yvClVEXFjfafP6sXnqY4dtXJ8IiEODMPGqN8Oti7FdgyKdjy?=
 =?us-ascii?Q?FNK0FZSNSgTCI6weJHPGL4zciD/ksMiSCbinyL0CdrqrGdBTBJZFVxPT3Tx6?=
 =?us-ascii?Q?TDcAhP+oQBbNVbdjQ45m0U/1YDR2eNlE2kYyjK0YWE9KNtDKL55UHiX5hpep?=
 =?us-ascii?Q?zZ2hpIxN4cREQhQSH+NM+ajgP29mRrTQ2C1hqTUggVG49HyAsZ6kzbtlLyYW?=
 =?us-ascii?Q?f4zSu9VrvVxJQDhmWceoTsHz0pMsMke2psg3sC9fB0OuBFEyGEFm+16F39yh?=
 =?us-ascii?Q?fFbSodOLtWOCO3lbEzTC2ei+tPN+NK6Y0k+pJhCvHowsmsz/J0Vj4TwyxGq1?=
 =?us-ascii?Q?r6od57K7nJ2CKCl94zcIQ11sUAOozVcyhMCHOZcPRGEf8spD+gQI4KxGIGfc?=
 =?us-ascii?Q?DE1PIUEqYB6KUPyI5AFKcZZdM0UUtmaAHhzME+yLzKlhYHniHH2T3Oxosd+L?=
 =?us-ascii?Q?iheYQ3gwhHFrXoqaH3hH4nsQMt5u6Felu4RAnyWfDPLr4sGVfKg2Eqps8Zx0?=
 =?us-ascii?Q?XF9MNnLReWx+/d9WkLdVdPjqN3Ll1j9Tx/UJ1dXgPnTU50bz2+Iqre7CM5Z2?=
 =?us-ascii?Q?4/r80wr9alV5qZIsG8MNALsUhfmXOV7Q/6QXN3GJ9KbzNxJzZQXHyFDKwoMG?=
 =?us-ascii?Q?EC4YqDnM7vQD38CMxZyZDh7ymCGIAVp8cy73kxaUTvIs1UczJvTeFRqeWP+q?=
 =?us-ascii?Q?LEFPIbpkuG2Jz8iRpu/kaNOpPC1xNI3z/7hAeidWAJLUMDxwqv3FjWfz+h5H?=
 =?us-ascii?Q?jaIAjV6vKjQXTucasz0svuyG89HkPjpVWcUqcY3VvM9wWAxopk7CIdIzi0S2?=
 =?us-ascii?Q?+xEy+E/85cDnC/J68wVVVj4Rt5ZTFQbP1W+IKTJczGNSAyjHV0E387MqhUol?=
 =?us-ascii?Q?hA2lRJEKGgcGCFZ+z54PAr/al7wREEzItdCcP0z2BlG0a9QJ2G1eqnHdn9Aj?=
 =?us-ascii?Q?40rD0TCLfVKwNoK7W6KAe9HFf9HYpuLuXraOcpO3sLDcoG0RB4q0l1tvZGHB?=
 =?us-ascii?Q?Tkwf2t4F0vsOMNCP6duwwruCwka/WQtA4afK+4+5f7w8v4TjnRS16PH0tcaB?=
 =?us-ascii?Q?m1MY+GXgXUEK1ww+4y2qyUMaBGE6KHc9ZYnchd/7lyl8Ekeir99L2HDMQSiw?=
 =?us-ascii?Q?btmM3QXGEZDRH05dwbikeSON9YlC+xdIIUsaO/dBOb08RSxAJXykpYattJWE?=
 =?us-ascii?Q?DgPyhrAKSMD5FTraQG31TT7w9X6ftesO8iScupGGqnZuuFunc2ylI71Z5eQ2?=
 =?us-ascii?Q?mmBRV4ALDBm0+S3QsDPEoAVjiI0P33c4cCjTcmv05RNGreu2qQwymkn7Wsnq?=
 =?us-ascii?Q?phIJgK6irJzE+47w0MtQwOLOW87AOBRiCrRB5if9dQI90H+cmoZv8ZbXYOmw?=
 =?us-ascii?Q?SjpIivol2A+biLhYljowl7PV9QNT/sSL/mI9wk7M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eabc9a2a-e031-4788-3acf-08dd92f469e2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 14:34:20.4448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hZ30Fc2yOs7Evz0haKxDmEnVmpS9U+s2jbpMuK4IYB481h025h0WMqlwnOaQ4v32SA1fsv/dmO4VScZAfl9kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316

On Tue, May 13, 2025 at 10:07:13PM +0000, Luck, Tony wrote:
> > On AMD, polling and interrupt are independent. We still poll all banks
> > even if they are interrupt-capable. I think we discussed this in a
> > previous revision of this set.
> 
> Can you race and double report the same error if a polling interval
> and interrupt happen together?
> 

Maybe, but probably very unlikely.

On AMD, MCA bank management is always 'local', i.e. per-CPU.

If a CPU is in the polling function, can it be preempted by an interrupt
(not MCE)?

> Disabling polling for interrupt capable banks happened before I
> started looking at this code. But I assumed it was to avoid double
> report.
> 

Ah okay. I assumed it was a performance thing too. But maybe that's just
a nice side effect.

Thanks,
Yazen

