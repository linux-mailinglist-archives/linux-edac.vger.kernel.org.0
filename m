Return-Path: <linux-edac+bounces-2739-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8E29F69E1
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2024 16:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6B7162DE6
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2024 15:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BD41BEF88;
	Wed, 18 Dec 2024 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SuMgaRI2"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A19E1BEF60;
	Wed, 18 Dec 2024 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734535223; cv=fail; b=K1qgbapv6M1cQX6ysyCeFJ6IL5KRuK94eWK8lEaperwretMqyUGfNKOYzTp5kHtKz66vY22Ndj+CRNysNaZEi3Qj6fGUMRSTCqCVDSOaVatFiSXmrGuXDG5XtilL0Ezw4t6BXNDDblz6k51jte/5ryQio0ia0rxlXiu3TBRQWAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734535223; c=relaxed/simple;
	bh=20+IADKQG/Gyc7fufnUgAjInR99rPPoL69KugxqAaGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MYu2K2g9Md5tBY2MDlgD5YYFjPymnSmq30xbrvPTqVlLgZVAwsct1PXR8rLA13yEk6OrnrwKZA5Rjm8+20kuXFNCDwyvePukIrhKTDX1KAwUwxLttqS2UoothGkbCplMOZaEUmqOxQNqoqqgjQjR+R/S9ZqDo8WA7oEo3ISG4BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SuMgaRI2; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIcxZTPpI4Gs0RAfu+0jZ/Wy55WoTJToKtKj9/UgAsgwEcCHMncBA0q97r+ybrDFOKJgFA8a4u44odEuW1sNQO5z+NaOBZ9z24LKmvGNbZ4DIMo8BRyXOdr5snGFKAox6vW86ASLzNVnwXkRJvMWTWb7otIq9KPqLoo4H6C1ZS/u1CaEJpycsaY2t4U2KCMkc1XL5XXr7w+0abtvbabNL9eCr8SKqYz0nA5zZCce1Nr7ZD4y2+ZS8AH/fmOKfukWIr6Ky+VIMCpxpSxuQ3qYOZkKMj8oQq2K5y4q1oEbeIMsWe5J1coYhXS8vdIgR8rbYAww9VqJpiiL30LGF4qcwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3x6wsBSDILdzKXinXNhdsjrvQxiYQDson6i11BiO/ZQ=;
 b=vOArVI0BBYysV4ygYWtnWj/pG0K8cSEIiFFinfTza2byP8gb2Ubz91RZ0TSaawXOx1kZ6DbvJA65rslEbHSmfRWoBrcG3RW4S8TtXs1/Mrp2Opyh5AUHk5Diyg0prX7EqjbI93b3LXJtj9fznHGFRM7gTs9Ka6PMTXdVUaVyJj3RLtqQHmc5LjoGLd4k7LtWjPo/ljWgooYmOW03p3YyatBZe4fOVQvZZgYbLTepuCO1FknuYRYTg4N4U79gt1LET0CFzx8QnEgMEwv2J4mK62eaIwgFEJ5FgFAeE1jeAPhIi0OTHAahsFIVNlJBisTZLmiGeA6F/tdLVoKYDr14aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3x6wsBSDILdzKXinXNhdsjrvQxiYQDson6i11BiO/ZQ=;
 b=SuMgaRI2ney9en01iJKERrxFJIYzjwj3ZH6stPg5ybMjSKhlrmI2d8VBSUUX7EyGy3LINgHmZxLotuAqJw251Wdr2kqPzW6RtX20Qe/jBJZC4YS3qwp/Qq0kKL+nJVfbNaHXmGi5TmgonkT5eCut+gC7oF42nem2tfkM00tEsBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 15:20:19 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 15:20:19 +0000
Date: Wed, 18 Dec 2024 10:20:15 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: bp@alien8.de, tony.luck@intel.com, tglx@linutronix.de,
	dave.hansen@linux.intel.com, mingo@redhat.com, hpa@zytor.com,
	sohil.mehta@intel.com, nik.borisov@suse.com, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/7] x86/mce: Make several functions return bool
Message-ID: <20241218152015.GA1155365@yaz-khff2.amd.com>
References: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241212140103.66964-1-qiuxu.zhuo@intel.com>
 <20241212140103.66964-2-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212140103.66964-2-qiuxu.zhuo@intel.com>
X-ClientProxiedBy: BN0PR04CA0160.namprd04.prod.outlook.com
 (2603:10b6:408:eb::15) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 7730ce8b-0d5e-42b4-7bea-08dd1f777b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/LxTx+uz5bplcKLco81iGQECmGEZn4S0cWQ13sCEemdhxdhuzN+ivGZBcsh5?=
 =?us-ascii?Q?emVIIyW9XlxeSvhIj11SiDHOAVe1H05ic+bDBiazKHQy0BeQH4FscnjqSQce?=
 =?us-ascii?Q?72vWCelNTXkrmXFf2QIEqZj9nDxmumAjTHL397vaGPEKm9SaEQmuk6N+I3qf?=
 =?us-ascii?Q?jOdWdouJQpMItKH+/ZPw81lPtPIGevk3HCCnTblhHxK6Z9ltEdEfTNMeflsK?=
 =?us-ascii?Q?r5DYJbeUUQBM3awFYuwO96zjqSl/VjS5uiUO9N5J8x460OX5WyeGHTrHESYE?=
 =?us-ascii?Q?TavmOj8bOBrdgkI8Nsp7mKETCSsG/GowzBgd5CNNjrscXn7K+kQ7fMu893OP?=
 =?us-ascii?Q?yN8fomlU6RMJf2cc3v5FumNm31GpNmOYLyCnZ2NcJ5gHTFdloQfZ21PPutsd?=
 =?us-ascii?Q?jH90zBN3j8KPmbx34rZJ/Hg1SNi8ysTSP7MWjfY1nYuBSthgT2j+mTXHvuAx?=
 =?us-ascii?Q?8RIPW5oe9wJVYXJEmRiLLbeiYTZAisWkxxYSGvkE2yyCmH8Y+kOF4mPnozaj?=
 =?us-ascii?Q?M0WmRRlL+0X59XSRpMXSM6qQIqN+oQ3h0A7XM11zjMUZTLmp/tVWrGQjqooC?=
 =?us-ascii?Q?BNYtojRRu4uZj25pK7t0rBIH0CZSqiNt55uAlFO+L2lmBsbn2LW/J6HKyzyH?=
 =?us-ascii?Q?EkqdiRta/1Rrf7b/lG8eOqTIWzjFZE94EFsiiXsDQasbgkftnVdHtxvm2hiD?=
 =?us-ascii?Q?vDERweZBuaWdhN0r4GX5vIkG+DdcMaTlEY8CDF+KBgxdOo7o3ysT0sFfalxt?=
 =?us-ascii?Q?BHPyzCOGrfUGhc8PaX0vJIkE+I6GQbgwLFmEhQgKQN59iBnC0wtY8sxnzHjw?=
 =?us-ascii?Q?VwiN1Bfweia/cWanh58c20XDfTC2biUePMayZNCtUeloHVBXfRCseIRYqnGT?=
 =?us-ascii?Q?p+BEE2OjBZQlzsotJ8ffT63dVKpgc12fzIOJJ8qkPN40ZJThxAHtVzahD3tA?=
 =?us-ascii?Q?9qlOx+blWP7Sh2Af29lZnWWEGdKw1BEmSl4JI2jQ9CY2r3FM7QmGgcyQTbg+?=
 =?us-ascii?Q?ABXPKhNccVIobhYy5Uou1GUXsfdqrp+LrlXgIJpkXUMQetS1m76ammKRzwmw?=
 =?us-ascii?Q?55FdAR2CxEYqitAmiuG0jPVEBUg0XGmzvH2ulmLvOcxU+MLUrXE2tc2O4Ojp?=
 =?us-ascii?Q?+8VLD0MZnbJQBaZSvausRh3dzZwyMAium9oHigi+1N05K2Ds6NuwhX2ya/GE?=
 =?us-ascii?Q?3+6O9PuMVO3DqD/LvcbJ9YqJAlZnHgoN1mQFo4gzITfCVUX3YPK6btiiDF2n?=
 =?us-ascii?Q?WmcSWdI0tEaE1pBl2DUGEJkthoMO1TQm+F5eMfKJnJSnn/nNDLMyv0I3impQ?=
 =?us-ascii?Q?yAH4bUW5gWtv3ME/ncMwC4nOkwjwa5yOyHXHFB/AmTCSxtME9bogvPT+qftS?=
 =?us-ascii?Q?kA7V5o/fV7OLAvE4//mEa7ZTnMwi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o198TQF4Q6iCgwnsyZBAllWoT0TdiediP3LKVEmz4edPLUqb9R+CpEquDXlH?=
 =?us-ascii?Q?CIwIB6fet3JNjUcpvImcYNllgmK6M3PUBmJGjIP2U7pS98TZHIsScrD05wwn?=
 =?us-ascii?Q?NNvTaSXxMAOQ6faZLVxS5Gz/ZmnM1hnKadoHvzTOSTAWQP2EaphdOcCewPta?=
 =?us-ascii?Q?vr+sKhssyBF+G85TvajORiQuxODklXug7P1T4DoL0/TjTd7uxfZyP5ZPR9y2?=
 =?us-ascii?Q?SbCOf4eboGbug+s8owhH5C8HUDpJ1Rb8hNln3lCgiEbX15A4NWMYnIKtf5Y/?=
 =?us-ascii?Q?/cxwe1zTlaEYWSC/eT0n3nM6HcUGmGPJAYhkp55HNSn1Dv6/fZ0wfIepGoom?=
 =?us-ascii?Q?keatOHYlreCi4WNuB7wsGNAW9h4u19nj6WqiCx1/pRLH6Oq797d9wh2yqsw3?=
 =?us-ascii?Q?bdORp6XQw0jTNDHPsrCtcwPMpBz0oR/UNSaHPlfthFYyMabbdnCtAHgB4Vgm?=
 =?us-ascii?Q?uLiLqMND2IfP+/nsMJ5rPqxYcpic10cF7aDPzMx0iL6lLYaNTVxQBOHCJWko?=
 =?us-ascii?Q?cIe1xNffONbZC/moGa/UxI7iAw55aE9QxcACbzZqx8vv57X/OK4BJBfuDHqB?=
 =?us-ascii?Q?t7rMiBzroyK8sxiDO9ZTZRk49JG8cyswgoXlU3ZVrBj7cImG9SE4t9PWuaMs?=
 =?us-ascii?Q?ciIUQeyHJYdF/RR/5n1x/9NyvA557fuEYMhSYnvWX89xvA1KDQmlZDmp/LLX?=
 =?us-ascii?Q?C2I/bTO/f40p2snRfH0+TEx6G2e8F7ucf/HRtRE0YopNT/lAGXDO2lNUwcd6?=
 =?us-ascii?Q?azmomunb2HfAxUBATP/zYE4YFMNq1NT/GJfqJtfxBNhvt3nfjmjt7tKN1PKC?=
 =?us-ascii?Q?butAuGKehcl2PUi4tWuL5UaT9icSdXAFpsO60IS2UtPkiyuPNQUX1Sv1WXY7?=
 =?us-ascii?Q?gu306GXp7L8iFr7jyL1/aKItwuASmNn2aT1hOJBbeTgqleHKQf8rXK999eoT?=
 =?us-ascii?Q?sKHltn206AVQSaMOlHJaOWZVCgyBA4INqSDA6MRlB9TvbU+mh8+hSxc16iBn?=
 =?us-ascii?Q?lChXIsjKEYJIKdcTqaM1ZUfaAvsnvz36Aj0q/nn4Cbh8A/TDm7XpHO4Yc67V?=
 =?us-ascii?Q?Tu8GGBMMI5mn5FXtkj7ShQ0md/vIQaIONkVPk2L2oJ2uedIkjZQDuHNMwOTQ?=
 =?us-ascii?Q?RLJpKkTRvRmsiaQe3h5lzlkQqYjWCy3gPvNu6sb4wxoWxOpx9yIRT44vdllZ?=
 =?us-ascii?Q?tCNOv5z3iYu6WsYcMyYYLSONCWmJr4fAv7Q8COgPIRdhqChau33WV43ST21d?=
 =?us-ascii?Q?SW214hmVoGeDH6z71t1/I2ksoSa9mJXFWxF8wkWsq6hBHCW69KvW0rpv6ZOH?=
 =?us-ascii?Q?onDUryyJBilFJBL6GVln3cWFaDThzupO+OnGLoYLxK3scTCZOHkMMyYl5w4J?=
 =?us-ascii?Q?qLpcQTiH/Ws5VOVPp4zDulq/s9uC+8AcTfNIWIXHl/PAbLG/f12SOcaIHY0w?=
 =?us-ascii?Q?emW58nMhmPxtI/sOQZ7VuU25VsDHj/2yqaVn0i1NBZl937e3HAaPlZc2XN3w?=
 =?us-ascii?Q?pmdKPlwk10AnOsCm1U/b50ThvprsyQ7+Di8cLByt2YIsbKoUEaka2aduNfid?=
 =?us-ascii?Q?UmxMw4V664X3Dj80iNz6x+SwuuStFV3PN4hbsA4j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7730ce8b-0d5e-42b4-7bea-08dd1f777b88
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:20:19.2466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMqbwrhRLkFrDuPKXOKOf4sHhoXjumy1IWd/C8nHF0AzOH5uNEWnSRmt9W2uS8fUAjDuH+IbkXqs2PPjTdehCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222

On Thu, Dec 12, 2024 at 10:00:57PM +0800, Qiuxu Zhuo wrote:
> Make several functions that return 0 or 1 return a boolean value for
> better readability.
> 
> No functional changes are intended.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

