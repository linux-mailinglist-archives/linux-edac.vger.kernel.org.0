Return-Path: <linux-edac+bounces-4776-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A64B5185F
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 15:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B083B54D8
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 13:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8FA219A8D;
	Wed, 10 Sep 2025 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KJmES4Vo"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26F8218592;
	Wed, 10 Sep 2025 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512418; cv=fail; b=HW/uKGpczakjSSSHHG8H4ilb1rCOGJd7jlw3vU0LsJdWXUU6MbxlGdhBDKGEl95fs2u7sXcE1/CwMbYhIplqMX9NwgHs06ujfZ5RM0EX6c/5zQRBFyMg6cwIy0XGpHcrrezNXDPDfGmKaKwRLmIf/q6DsN5LhlOC/2DbViL9qp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512418; c=relaxed/simple;
	bh=7lJRZU/4sjcSJsuRoOVUS8WmF4b0whQ3vlBuXlTwrS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ovzHuo4MtEfh1TsIW8KEcVTGDaGGCjTW56uRUK+9M8WqiR3DMhKLWcDgRp2UQdJpRCuVjRXMaS7n7tGYECTBkmxCnE4pXMsRdfv8HZdcSRS6GNW3OO5j6NqF6EqMm+r3UBY2itwvLWoYLtVcroFwZrocYYk5dLMNO7OfTI/cYVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KJmES4Vo; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpvpMaCXyp66a+o6mDUqwVV7bLrDVWel7ybtXj1vas1uHezn2N2oxBf12T8hy3Cqgqijst3DVbQbW8zJMr9cUMz6BZfV+s9AjFhIG11y9IE9SgMqmOz9IUO5Hxw1nI+cTETxzrPXUf0YiWwG8Vn+zkAfIPAfdbHp5O82jPsDcpwU2y9H6+XynLhQQfpfV9UgYc3gV8cODjoGCoinGuwS9MQtWKiNmoXEGinhXKewQdGjiXbYNIrokAsteZBbb5Mlm/6eaA0GozNxFofC/8rAH3psMSP4TcQR3D36Iqt8c7rbE2LN5HcdHrx23GujgfhQ0gzwl1sBB+Gl7FKFVn6pKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lcg6W5zBIOvbEB8Eqar5lo02Zkf4CYeF+n+Y2CRz9Ds=;
 b=ZIGtqXsQh+NOtNeLDWzRk7S/3ZfQ6tlEeu6vZ97D6qJ/CKYb75ZBRa9w6gvp+Q6lK9vXNo61ctRSHwrCX7Q4MYtoKsjuIS3JcsPIU6v/EvBxnzyexWS9D8PHupqn5ePwjuETSfumcwPvPSyJ4KjeFQkc6hq9eAMKlnjFSGkhcb7AdvI24GhJbg3WhejkYmZ0XySIzYqO6T/0PnIYnkDReP2gMgYHnsGngXa2Tzu2jQ8Nu3X7/Ml6u6sKTbphBuM2jKLg/zt3nYP8ND3naUpu8wTLsNL4GKwFpw0/XwN74GB+wKRno/uH/r9MNNpw+S2wfcL4fptqGtd9gZwbzi/nvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lcg6W5zBIOvbEB8Eqar5lo02Zkf4CYeF+n+Y2CRz9Ds=;
 b=KJmES4Vo7rjoOs18n0YEYhk8eSLVAVoh+eiZXnt4Ue5vERKaWzy0JwL2a+xvzOge+cPoqoj8VO9gb0PqHm+kM3TGTbIVThlhAT8rdDJkIEAIXZgZP9t6V28HFMMYx/0ZsjRuJSoIvGm+0PWxYWtmBfsG0Ok7JN6IBtX8PiE1fRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 13:53:34 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 13:53:33 +0000
Date: Wed, 10 Sep 2025 09:53:23 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v6 02/15] x86/mce: Define BSP-only init
Message-ID: <20250910135323.GC11602@yaz-khff2.amd.com>
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <20250908-wip-mca-updates-v6-2-eef5d6c74b9c@amd.com>
 <98d80660-7140-43a2-b17c-07a0884996f8@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98d80660-7140-43a2-b17c-07a0884996f8@suse.com>
X-ClientProxiedBy: BN8PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:408:ac::42) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DM6PR12MB4172:EE_
X-MS-Office365-Filtering-Correlation-Id: 348ca14e-5bb5-4a54-9285-08ddf0716ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bO2O5IKoVvphoXkKSDF0sPyf0hacBo+MgQFvZYP1gtfswWr5lNYrR+Lg2mNe?=
 =?us-ascii?Q?czG/bg4B4uZGSbXm2XEC7BQP4z3H7Bwmabc9xwD5AlI0Sp/yrt3ZEI7E67g5?=
 =?us-ascii?Q?Jaoq0u3RPOl21zNZ1JPsMTVxHCvCG5CST0T5ESEzfmcJ4vYNm+0nOt0dZFKB?=
 =?us-ascii?Q?ADPha7KZdmMB1g9eUj/DsR2pFyr+DF38/qeb18k27GECZvFtPfJuLwUZ6F66?=
 =?us-ascii?Q?+wsaxl+2GG75u2EspzOe8hYO94wzzWtjxwBq4pFZvxLpCNNUJqLf5Gd6tldD?=
 =?us-ascii?Q?zODjhs80/XRA3Lzdpb8h93kiUW5l6bAMLEewk4MbY+JX8z/057X2TbOmIv00?=
 =?us-ascii?Q?usoukZ0sYf1k14j6yCZIMVkwUaYj2HzTgpsHDdcnfW8dfpEnY4b4o69tMRzq?=
 =?us-ascii?Q?L6ULejR4qQp75IIwohcnorlrAyR+OQ4aLGGKozxvFtjom6W/YR55+fPuD075?=
 =?us-ascii?Q?M1gLVRbXCVqrsZn2yI8Ti1kHbH2U03QL0PDik0FKJXew++GyJ5TO7IJsMIAj?=
 =?us-ascii?Q?uNPMhqMI0SVDgk6isSnosdSdDxsho2g4b4+g6llF3zGYwbkS1WvQ2h6tBAUm?=
 =?us-ascii?Q?RMEgVvBF/SFSGK6T3qFlbbrPAdIZfa6eAtPOVBbuxYL+e3EKwWJjFlbEUqly?=
 =?us-ascii?Q?dycOOtMWgNTqM0eNJky7IMwlp1IwB57Kdk4IBtuzWfvLgJVVogQwebwjWcv7?=
 =?us-ascii?Q?KMlLJnpeAM632bIFamyDZ/PCjQ5RRWyhwkFFjXVOCbdyCemA9n82Vd0bHQi+?=
 =?us-ascii?Q?O/Pse/FVImNgAXbPwPxZW/p/3jBiJ5nFG6lgoNPc44hKyF1eqqERH0l7GJd+?=
 =?us-ascii?Q?oSL9AwruDoxuSb1Bs2Fj+nmKpaJNhWbEPQxtwLLEHxZbr/gxvAa6mEmASPW2?=
 =?us-ascii?Q?IPqlPFrUtbJt8Kd7lER2DjwqgYh2iSCr0Ln69ELSurmySiqiBVLHxS2Zujbf?=
 =?us-ascii?Q?OVZFLzQBUyVs7tX6HE1rsxHmhjB50aC288xhIAIuSSfda9/qSxufCkLXu9B3?=
 =?us-ascii?Q?xjQxu+Z+jhyLSR0qStBg+VKjdmoDBFGm2xsQOEmBU5B+GHf06vcbI13QDgvD?=
 =?us-ascii?Q?iP7vouEtivZC+OAska7Qjq+pVsYD9ZohbAkhUuhczH98IY5DRRh8e6Kzl4Vc?=
 =?us-ascii?Q?JEoxnToYUyGLUXhQ9g3EAnIMgm95IljjucSx+BMKsS3HYyqILbDldo+Dz56H?=
 =?us-ascii?Q?0tDOOxdO+mM6KGbzhjZwa+IOmbld88pnae+If8UHldr1gdXaiv6vxH4IwbKh?=
 =?us-ascii?Q?tjvI1AcHPoxEXRqaurPLSxypfihKBZha+SUx8K/wmrpepmnSe73YlbFpOwPy?=
 =?us-ascii?Q?72cjRpsF93cuIrK1tn+jn1pfRanuPo0uuFm2udTNUeudpYei952HRwPzL1Fm?=
 =?us-ascii?Q?edqaDDZ5QAbQ27MhRqwqn0pcJ8w0VhVEEqhrjX06XBXxKdGvtd4jRn3EpyUg?=
 =?us-ascii?Q?YSZkOt4YQMI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gcqBTgC2WJD7AdpQngjxZqaamQ6NBySxSKre2y8grXP2hBOGRrK+1FjYob5E?=
 =?us-ascii?Q?MplB79X5WlcP8tkeExdc2OPlYMf/+DOfvqbZxu7B31pVd/ErN4Af19NhV/ln?=
 =?us-ascii?Q?cQpzfNOD1u/tO9W96tOgkuk+llIv0iKuIYBYxA8DCnqI3I8cuYhsNFIMn/WU?=
 =?us-ascii?Q?MIq/sOYttKmiHwtOIMiTG9D2FGpv37CM6BmJkjzsoo3akyxyYTaz+64B3CZJ?=
 =?us-ascii?Q?hLRf03/YoBjG8PmEGYic0Bs00Dmd6MWt+0wEobLd5WMOOAjbpGQD9yx1K76K?=
 =?us-ascii?Q?X/kAj9EGvGaCR7HggKoF1Jx4JmRBMxgs1YWLLsID7qiut8Tvjc9NA5nhJq4l?=
 =?us-ascii?Q?Pk5Qq5e61Az505ZTE57gcR6APZ9B82rMamXAjGQTaOhpoIRTL2zSxSi71yco?=
 =?us-ascii?Q?GSWd6sWOuEIF66xi5rExyuGOvcoAjhcn9jpR0KcQkP6wtO0Plq5TzgidAfmf?=
 =?us-ascii?Q?WEkFYTuOiuzXMCHGYEzBPLu1IzT0C4MkzRU1oPpG2ps89n+7RJtJ1m3sZeD/?=
 =?us-ascii?Q?zmnd1uTaBLgMywHi71y8Jq80FUIG/ViOIw9cbfm6dm83PVHtUol5nmpzacKe?=
 =?us-ascii?Q?UD0uoTlQdUZdRytvXVO74nVS5fKkk6lFqlikM3qq4pp9VwV8q2qq1d77/Seu?=
 =?us-ascii?Q?iEvyy1DX7kYmf78bFPNWb7R40ybLs7rf0vLvChrdqH8qzZ+nWIrk0xYaHgWf?=
 =?us-ascii?Q?tPCYTd7d3MFFAE7DZoc1z3tTacEXbtfMLYxf/hWOvbVgeZ9feuXPlpD4lqwC?=
 =?us-ascii?Q?Kle+XwTTasHhzfioVAPrpKtPaNphcNBsT4/KZ7BZ5QFYDA1HrFwd0iNp30LC?=
 =?us-ascii?Q?JU1LylOXNradpxgHOBg/erIko142SLSd63rS0I5u1cNjdJhy+7Gum6QhY2eh?=
 =?us-ascii?Q?fCAFALrb7UaU9//amVXCOJ0lOy9ALky4GD8DBtOV6XX7cmLzNhh1N3/r2ax4?=
 =?us-ascii?Q?aJdteBdqRcNJXBgPQ/gKy6F8gqds6WXUTh+OnA9nc5MMqGMOZk7NZF2khPVz?=
 =?us-ascii?Q?EBOjWjS48VHKtt4u4FXkueRTd5yvXEoIBHL1Du+OO9LS3YsK8cZd4nykB6nI?=
 =?us-ascii?Q?mLZGrJneWyYca9Vohwal9ERdKIZgwg2hgxK+V3y3x28E+8rM/NMn4sVN9n6Q?=
 =?us-ascii?Q?dm8BfNqHUslT5IQS0+47TQlBMMyZdf/Mbp+6yXijOmWGtPLzaJWr/peTJXr5?=
 =?us-ascii?Q?lAOZPGRu9hHv2YnkpO0tw22ZfkDh8sLdtZ1bBdeoYyKEChQwF07v/1ejS0K/?=
 =?us-ascii?Q?H6BvIvLjYdPDHPj3t+/1/eEimPX3044SYjgmrD5thVeNKon8HUQ3JBH0X/Rt?=
 =?us-ascii?Q?nk1u+a6dz/+C9xk5wSRmk9KdKZx1ao/zPWc+bmD2AlfoJVG8wl1VlBrx9Jke?=
 =?us-ascii?Q?xA7Mvc81hyl6u6gE34GjrP65lBe3P4r38rVo+IT2DIsHiQwwrGdxXpuJMI7z?=
 =?us-ascii?Q?834py/JBbXV4YrlzI1TEfIhnEI1SF7ufSpUxD+fRDAohOWNVFja/w/X7GAWb?=
 =?us-ascii?Q?An9TS0WeCuhhtnV7IM4ocFpCHJZ0ef5aCFGTqbncH688+26K8Qi/BRNxKyxm?=
 =?us-ascii?Q?pmsMhWBCbje3GejLANCThAMQsU2kDi4fQDBczAcX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348ca14e-5bb5-4a54-9285-08ddf0716ec1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 13:53:33.8893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sEclATUHrLYWl4/fYd2jH2BAqHUXWwS8XkeYt4WRmU2RiREeFyE8CE8nwsUgyO9PQaZFRdEl0Clge2GkFIrow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172

On Wed, Sep 10, 2025 at 02:47:16PM +0300, Nikolay Borisov wrote:
> 
> 
> On 9/8/25 18:40, Yazen Ghannam wrote:
> > Currently, MCA initialization is executed identically on each CPU as
> > they are brought online. However, a number of MCA initialization tasks
> > only need to be done once.
> > 
> > Define a function to collect all 'global' init tasks and call this from
> > the BSP only. Start with CPU features.
> > 
> > Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > Tested-by: Tony Luck <tony.luck@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> <snip>
> 
> > @@ -2240,6 +2233,27 @@ DEFINE_IDTENTRY_RAW(exc_machine_check)
> >   }
> >   #endif
> > +void mca_bsp_init(struct cpuinfo_x86 *c)
> > +{
> > +	u64 cap;
> > +
> > +	if (!mce_available(c))
> > +		return;
> > +
> > +	mce_flags.overflow_recov = cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
> > +	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
> > +	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);
> > +
> > +	rdmsrq(MSR_IA32_MCG_CAP, cap);
> > +
> > +	/* Use accurate RIP reporting if available. */
> > +	if ((cap & MCG_EXT_P) && MCG_EXT_CNT(cap) >= 9)
> > +		mca_cfg.rip_msr = MSR_IA32_MCG_EIP;
> > +
> > +	if (cap & MCG_SER_P)
> > +		mca_cfg.ser = 1;
> > +}
> > +
> 
> 
> LGTM
> 
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

Thanks Nikokay for the reviews.

> 
> nit: One question though for those CPUs which consist of P+E cores, is it
> mandated that both types of cores will have identical MCE architecture, I
> assume the x86 world will be a lot more unified than Arm's big.LITTLE ?
> 

I think technically no, they won't be mandated to be identical. We already
have per-CPU feature bits, registers, etc. And in Scalable MCA there are
also per-bank config bits.

However, this doesn't mean we will have different MCE features between
CPUs in a system just yet. The architects do try to make things flexible
and scalable just in case there is a need in the future.

We can code to the architectures and be *mostly* future-proof. But it's
not guaranteed to be without bugs. And it's not guaranteed that every
possible case will be used. 

Do you have any concerns or see any issues with the code today in this
area? Maybe you're thinking we should have per-CPU config for feature
bits? If so, I agree but we don't have a real need today AFAIK.

Maybe others can comment too.

Thanks,
Yazen

