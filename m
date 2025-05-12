Return-Path: <linux-edac+bounces-3885-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E532AB3C3C
	for <lists+linux-edac@lfdr.de>; Mon, 12 May 2025 17:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1AE19E085E
	for <lists+linux-edac@lfdr.de>; Mon, 12 May 2025 15:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC9C23C4E4;
	Mon, 12 May 2025 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vggVx81B"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB0723A99F;
	Mon, 12 May 2025 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747064118; cv=fail; b=RoQ9/iH4qfQ7fVxqlul2p0bs5RYH3lagxji2ugIdrybf1qg/Lulwb+gOgBfE7Tut4QEULcSt1bljD23YriAhzBBulUWnuTc7qGo82wrEUU4NTd0J5M9VbGtEy/uvw4Hy1NivdHk1iBzscREMYKctgCqjCjmp5MWmaJYHG0wX3ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747064118; c=relaxed/simple;
	bh=wUARdmRtt8jq/57EgJZH5uTixPmGEtrdquPM3VJ0Ktg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PHK6rgDvpo9e9iCJDZ2bW1fI20s2DfL/o1i35jm9k9Xw+8p/k++uRQjpEsfAjAqXgCpP7ANfAU74A10031KkBg/R0ZMJN+3bCUcIjBNqFQvmaFTFbBcJFBII4j/prEUqSUJ8eZrQe1X7id0R1gPjTw/eDGXt/oluPxS14u/Qrjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vggVx81B; arc=fail smtp.client-ip=40.107.102.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPQp51NGwGoA0dbXeYvgwZU0+CwnIQseVm3VzwOrfrj+QRJCGyGXfjU42mQvNPtwHL96txmvoIhC5XWnRBs9zE8/ULICJ9I0IYLkEV2235CqIjHSV5h4QK3SR1Uu0Y1NChjQDgm65I0GfwcQP5uHR/wNjeNbrYA2AeqPg6PEzjQy9nNhfivdhxZZXaSRaU8wlOYrsVrI/wh0TZFPFN45eNCDs+TxckOY4LlsV0sQAoSBlFL7c0ZkI6Sx60jsLt6qROMOkjPv3WcGotesUAroKK9vRbGSuKRUwd7WavDvfW+DODdmfc3vQFbsj6kGHhRrWCNiym7VRFXF81X9+sXNwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNlnUF3NAKxPJY9fEhI8o/lJX/AR/J1uJYILJrUv8bg=;
 b=a3KNpPnfVf3uJBIWvGZhhrV4vQzZ9joiJ0S3iHhEdg+9eKVlHh648SeBIqQm9dwM6tDMarhPmBMRhn9u1GZinQp7YoicC+x9Ibr42HDzAS4T/jDjXiV4tN9AOE5gaUUsdNQ+rHvYXPAUoYv3Zf5Qy0y7tZzNpS8HCXPHj0zDgKehoTUmsx2SkXJFCNdpeucv1Aih6z1oKRuu+uKv47rovo7Cd8floQfvOMZfnlYRjrTb6va1NceyMe+tneUbpJCLJyGpnzE8tXUeRE+3CUEc0+sn189rkOh+Gcvk/M0KveypAuBD+4r9RaWI8ehwvyGAqhvUeLntBQEZCviKkFmRXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNlnUF3NAKxPJY9fEhI8o/lJX/AR/J1uJYILJrUv8bg=;
 b=vggVx81BxDthUFCCbFZ/FdCY2Tkm5xchAUwCkAgdtQyjx5kgcSzxey8zNnko47PtMZiEinnV5BNcgie8Qri/NdKNHgdUF1C+xmxNL5RR9p7D5aovr4ZQ2LM7fdg3op5OvvJgPwMyPjY/jtH9sGyx4T7yiMzHsUUUO+ZVw7Xsi70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 15:35:13 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 15:35:13 +0000
Date: Mon, 12 May 2025 11:35:08 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 15/17] x86/mce/amd: Support SMCA Corrected Error
 Interrupt
Message-ID: <20250512153508.GB2355@yaz-khff2.amd.com>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-15-8ffd9eb4aa56@amd.com>
 <20250509193721.GRaB5ZccvAs9ST_3IM@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509193721.GRaB5ZccvAs9ST_3IM@fat_crate.local>
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MN2PR12MB4096:EE_
X-MS-Office365-Filtering-Correlation-Id: c6c06c9d-c84d-42a1-5b20-08dd916a964d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/u4GqyeQg1TeprjvTpWeyTrVQx1I3IKoWRTeUmS7B848FlK6vcWtyIzl+NtZ?=
 =?us-ascii?Q?hRzabiZQVyCC3F4iBxzFL3kbkmiup3GpKE532N1C9e7TkUrFWByr5I7COAdE?=
 =?us-ascii?Q?76a6AKde/tGMdcHjUDMwqn/8uaMBSZG5EZHnR7xWBuP099DJ94yFevF9aaXG?=
 =?us-ascii?Q?8gTOIvv5Wo0fpGkAOTO4/myy7nN+w8IVBvLjI0qrqW/67GHFWyx7W3k/PpSO?=
 =?us-ascii?Q?+zMxdQcovVji8fg8iyUrMy2oBAuDq05bLpQWe4ToU0jGY7+87E6gyhczAC/s?=
 =?us-ascii?Q?v6COZ8e8JTUvSF3+vFc+6+RyLnxkSyUqRklB+UFlK3OoBHTxsEOcVCRIwXap?=
 =?us-ascii?Q?J053hcTooZl9qyn5hv7dHvwbKRjm5LmfQVkbOWqiJaEIs2/JRfwc17Xsy1EX?=
 =?us-ascii?Q?dYu6+ahr0f8xmRdu9ORHerdDUUeqOWZpUBfcFKTDNJuoPYRICt2bbE0sriQa?=
 =?us-ascii?Q?SH/2A4I7Z4fAsGVdz9IXvVVMAYAGiKF2rmp0i0dwokFjcXAcCeGnoNNHOd84?=
 =?us-ascii?Q?C0pykNHWbDmHzwhdsmI87f1JbBQxcRusqa3I7ERC8CdbwykgOJEneSTgibcT?=
 =?us-ascii?Q?ehhf21inbXM2+FIwYMnrZuQMn+eVxo3dwxESHmXgNonvxoOmVlSxzsryKiN3?=
 =?us-ascii?Q?B1sER2stim6calCl1hLkQOswNd7ISDCkg49k/cWSVdY929efhdGk2iiRB/Ja?=
 =?us-ascii?Q?Z03gWHzB8jQ2ENWwX8xfZYXCAvjwin73wuzClmTr6UjHJWhWlrgMQiAbCX3p?=
 =?us-ascii?Q?6J8OY5nuMZPRW9Hm1N99WqmnYEDK/uW4ePg3xG3ADLtf2wnAuLA2mWy9oTis?=
 =?us-ascii?Q?tCmH8W0AKRAnn0wOLLXelAH9OgiSDsEKTfNk5rHvwYYiXWwtDX9mbbp9rbxN?=
 =?us-ascii?Q?h9UTp8oas9sGqSmtq2SJwVCrkEahwGtwt2bsWLwCH/aCPsnnnKnf1z10leP1?=
 =?us-ascii?Q?laNy4t25N/CPrpjG2zOyYJVP1xeEm9EwXCPJaDeKhhBgBtcS6lyGsDlM0ftQ?=
 =?us-ascii?Q?bDtwaSMN/FgTQWKv21wuDmYhPFGPmfOlQktDp6vJNHE0tn+SDWBj4ogkKUmf?=
 =?us-ascii?Q?omiNMq9W0lICoycyfSdyyfX9xgzkH0hXvy2J6tfolG6TftXAqxCSIyjdAuS8?=
 =?us-ascii?Q?BesL95BZRiFcxBQP0No0tCePc/4H+JsfFqb24e25MvVJhwW6wqBTi2SgJ/pm?=
 =?us-ascii?Q?a9xgSVhKlAlN8pbLg7AP6ytlCQMOH2GyJQNEOCpODTHuB4NNentF6TKFKNtz?=
 =?us-ascii?Q?fd1wkiKVfv1M6fJC1JsFYcAYh5qCKiuaiV4zFsoy6ntIk0Ic8ksUgrz4+I8s?=
 =?us-ascii?Q?suLytiiN0SdDXqtyQ7P6oiSo0CnGqaSZuXV8YN/ieBFA7goTmTtwg/t3sSQi?=
 =?us-ascii?Q?OzMYgMyAUefBCuKurC6BQIpaV41pcBQCTEAL2OOzvFQFcLiEKk9IFFP2UUoP?=
 =?us-ascii?Q?JZl74WzfDkI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LFXu/6Bnuw0WqgxI2+uUtYROG5angwBuhmY6ALVrU5Ox+iMk7CRLh7+NibFt?=
 =?us-ascii?Q?VxPGPYZCQ26av95cOdC4RF/9zQUYPOVBFI+Gvqge1JynRSikA8/e0x1I+gbe?=
 =?us-ascii?Q?cEoXREB4PIvMTDhNrxFdfb5Cz81w1rs6OET6l0pRGJOK6wNPm83AVgamqe+Q?=
 =?us-ascii?Q?ZMIX2sbnGO8kiBAiIkcLq5Gmm304OqvIZ1Bly306Sse8Xsm6m3pG4YmQq3W9?=
 =?us-ascii?Q?5tuFEY8Na6LxeBK3JPE7rnuYmzyRkia6bEmsbxK54bV7orXcjsmeINFFx4l9?=
 =?us-ascii?Q?zQ+ebE3AZBjE9SD8bidq1UhE7hu1RuhJn1CtOqFK/NTyzo7QqgR/Sep5gZjQ?=
 =?us-ascii?Q?bbCdgejklmnY5AOKPuM4HABaYQd62wJTx00mQzaT7o+TtYokvOI8HIa1hZ4h?=
 =?us-ascii?Q?PtdBWFlBVgibf/8WVynbl6XTxOkRbCKmX93MxDQPR6HQXX6/8pvJzd2YNfsw?=
 =?us-ascii?Q?mbu0mBdr+RmyPHv5edSJVVNSqQydGCyGri0jMPS3mfQLFeAXGGAi/d2mfSAp?=
 =?us-ascii?Q?XYCm+7TgV/QM6YwQ52L4hwwli5CKVfF7+lctqnP05k31ix+gs6RgLFEXOXRa?=
 =?us-ascii?Q?eXvWdOxTgXq/y+1bNbT5mRL1j6Z/PXLjnhM9EjfPIkwqXwNSl+S+TE3wUzoE?=
 =?us-ascii?Q?KJOYlNH8oiElfkfhYdIUUDFlr7tMLk+Z2I0tBZQk83oqZlrTzMwFkAU8MOw0?=
 =?us-ascii?Q?kskpQnLQhtvxWvABbyLc+E/qt4Xw+kBJHCpQ5P4C6IlmJUzY9JRAgNKO9dmd?=
 =?us-ascii?Q?8h2PB7M/QSgD7QVK0Jd+Q+SSXlhMIoTwMrAIIdnwt/pdDuzzpqFrUoAe6ZvD?=
 =?us-ascii?Q?qRqx547t+U9rU57sOZn2Ml0HU+bi4lWb6BsfeoODrkaThPe2v4nDSGJSJGaR?=
 =?us-ascii?Q?s/nOzqaT/B2NgFiPRwbk3CvcvfEEZrUXhikoHAUrF4RuLo6K6jq6f93hGUyy?=
 =?us-ascii?Q?kB/NC0skY294BMKURva9wkVlz4/ff6zS5/XM22UZeQ9XjiJxgg1VjsgXS0pd?=
 =?us-ascii?Q?m1UYprjpKsvoOXn8m/O7hiufZd3NjXlAcQT0o3j62nKX9V0spyd4iKTfVsRh?=
 =?us-ascii?Q?qq1rVZibHkj8g5ReSU6Fgoaau+yNjZ2FP9oW/9L0YCqk9pPl4Iw3rBsIqr5A?=
 =?us-ascii?Q?F1bP48hecuWgKCz+ZeOv3nJ74+OiK8ghf+5y7DfFlbJaQjvIRDi5GgYtWpls?=
 =?us-ascii?Q?Hi/jiwORAY7SfU8lBJbYpMYFqIBrPs8Tf6di7VtBeRLAmHgPIc4oEI0ptFIz?=
 =?us-ascii?Q?5Sf/TPs4ik+3Yt2BtiCVPkFyE+/huhkEIqqBCHWPjlWnkJGLpLRzI0HZkc4j?=
 =?us-ascii?Q?yOm0ezISQvV25ZFrdOCpBW4fXr4q73zIslVhCWc5MX+lIcfiUgLOBDZMiB+G?=
 =?us-ascii?Q?6aTQIoeGNLg57aHtqtXOQa0ERWFcZqie+uzeQXPP3xwauyteZAT0PVphhzaH?=
 =?us-ascii?Q?NiK4J0JSF0Z3MkuRkPbzOk/Kltjm0QeO4P4ivyIgciw8I1pXBNY296PWkxR5?=
 =?us-ascii?Q?XUBJmMRC0v0Txk5L3GtmhrqK6227x6sVVS8L11OQTNh7TYprwSSy7FNqgj5p?=
 =?us-ascii?Q?6ayTplTH+4nheM3603k6N52rU1tEyfD8rOhniUv/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c06c9d-c84d-42a1-5b20-08dd916a964d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 15:35:13.3453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8WW8YW86sd3YjNG8p+Pb1aIrxABa+CHwLWzP6p1YlSlz0TjGSY6eUK3/JfwUf5grcZTUcbjl+1Cy+yoSazDmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096

On Fri, May 09, 2025 at 09:37:21PM +0200, Borislav Petkov wrote:
> On Tue, Apr 15, 2025 at 02:55:10PM +0000, Yazen Ghannam wrote:
> > @@ -306,6 +306,11 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
> >  			high |= BIT(5);
> >  		}
> 
> Yeah, the above statements explain in comments what they do so that we don't
> have to define the bits but use them straight "naked" with the BIT macro.
> I think you'd need to put something along the lines of that text...
> 
> > Check for the feature bit in the MCA_CONFIG register and confirm that
> > the MCA thresholding interrupt handler is already enabled. If successful,
> > set the feature enable bit in the MCA_CONFIG register to indicate to the
> > Platform that the OS is ready for the interrupt.
> 
> ... here.
> 
> <---
> 

Okay, will do.

Thanks,
Yazen

