Return-Path: <linux-edac+bounces-5043-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A52BD9D07
	for <lists+linux-edac@lfdr.de>; Tue, 14 Oct 2025 15:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E685535586D
	for <lists+linux-edac@lfdr.de>; Tue, 14 Oct 2025 13:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B06926A1B6;
	Tue, 14 Oct 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="00k9dX7n"
X-Original-To: linux-edac@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DDE13C8EA;
	Tue, 14 Oct 2025 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449941; cv=fail; b=U6H/qgPs6fEAVNf1vxSzZGYNVCJVDgxZ3sPfs6h+9gk4Z18vjubA8nGMAVISQuaeEpVW1WwmGcDccMnAAN6EGUXMhaJCOqPZhibhovpv8DwoZFmpSKaVPF87b54ps2MlBkUUUy8Gwb/pPgDbMrI3eJxulWGmNpfbWstzTX3o2s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449941; c=relaxed/simple;
	bh=i781QsCRGNfAW3wLU9x674bNsrXcOdQeq/WbzJgKkKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l6beEj/dqeRlGqY19qTK0NL5eeCempW2X9UX3dPfhK3kwR8+6R+rmPOnhvzpKko9bAPuHGnjQ4RnCVdFmX3tQb+5PHPehSyn0WA/kfUak8EhbJ1knUzUnoAkdkhLcBg7osMgPzCGKiRY2V23dE+lXZEEvkKeZaSb/neYkN79Go8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=00k9dX7n; arc=fail smtp.client-ip=52.101.85.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHgaxVQLD9zbAImabaAaO9tR1gigH/20B2MyTTC8N87/762bzjPNq8Pw/Anr+RNRUuBi7hR3LzSRNHIG/ngrLrNLMeP66Tl+8vQlwypRVSzGIDOS148ceuaJVDjRviVbKCF1gNPVPtc4tncr/3BNm1pNnnXjXp4Tf4gCB5tmj+2NvzSpU8L38BnksIZ/DPXTT6f26apiNrCRVuhDafx37bHVtHKnFAOJuqk3z06zsSrbrv2M3ThcaB2tkakx0+bXHKrEwid8K6zcPvshJddsR9QSBM3Or4lK98fNj86PHnEsznbgxz3MEJFRswJ/ylRI7LsXh1RUTz21FLiznJUCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZPZzPlJVczumAXNYd7EB9NrUe7/FbJTqXOzo+/VwJY=;
 b=lTqkY2wVdPDba7fa94VOf2DbKHceD5BZasKQC1T1+Wr+VAAzfOjbD6R+ilbekTKm/v56l74QQ1WjVj8bOVYhetJvrZzPJP/C/w2BXjAXAPgwbwOwfOw9ku2reVASyTxPtA+YdAq6InUPnYs1iw/MaYr7HLmcN9IhB03tZKMtpJV5Ghqbm86Vu8iWfXBOneaQRmDEHPfv745qn1o2Gi1JDRygrvgMNLUyL2xsJC9HInL+kqGLpLefZeNNVyH2uiqsmPFCsOhUwdoRLSjXwEa79LsDNFg1B53zFU5p5snK2s0cBiAQwWNWpML5la+bHBfeOPOOwaokCIfKYnOUhfYPeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZPZzPlJVczumAXNYd7EB9NrUe7/FbJTqXOzo+/VwJY=;
 b=00k9dX7nh3ENbBJMMzmdXjfvAqtkriLzGZ4jr2+6d0L0CffMczcJtmay6LGdxjLNbmzfUl5Dei5av+tdd4Q+clTIpVQFAFHwq7SW44KIzPEBBRK5db1LP61KDR45XdwDB2u5DoHjAvUnBXS2R02GQ8aEXIu14vWV4wykzt/xE4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DM4PR12MB6568.namprd12.prod.outlook.com (2603:10b6:8:8f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Tue, 14 Oct 2025 13:52:16 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 13:52:16 +0000
Date: Tue, 14 Oct 2025 09:52:06 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
	john.allen@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Incorporate DRAM address in EDAC messages
Message-ID: <20251014135206.GA361227@yaz-khff2.amd.com>
References: <20251013193726.2221539-1-avadhut.naik@amd.com>
 <20251013220019.GFaO12cwSvbedQwGr6@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013220019.GFaO12cwSvbedQwGr6@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0489.namprd03.prod.outlook.com
 (2603:10b6:408:130::14) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DM4PR12MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ffa0c1-e34e-4447-dcd0-08de0b28e278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7d/xrl2GDIbrOPFvdxa4cI3DqcIM/DhhzXE+KinnLgoSrv+zkhuoy1vit8kE?=
 =?us-ascii?Q?MkW9b8QJltZI1wQ0JXTHH0tvOk/jCLutkJpEaFUW0F+AA4diiQ/XqvKmvliE?=
 =?us-ascii?Q?wXlwM3OTdoehrj615TjjhAPuLeasZGrEpymLSsx1NhIH/pXoIfZw0lXR+5IN?=
 =?us-ascii?Q?9dXwMaNnxskNBRZ7bAb8ewn5e2LYBJzJRhZFDr1OAQSwbcgMQZRFerrj6gIM?=
 =?us-ascii?Q?+uHu7yQkTvgakhJo2ofxdlcNdd+bhQ8XH5lrwNErf/QrWoeUZCiO218u5TlX?=
 =?us-ascii?Q?nfOqB7z75YGSQECgIYPj3cou/VrkQ0PczaswOY6/NFjghXP2n3MKzlzo3Ccz?=
 =?us-ascii?Q?es2Jm6y55CLAkuEesn79aBvIft8w3W9L8DZ0cdTAer1Fuz6csOvgOq+ERDmt?=
 =?us-ascii?Q?bKVLWSmV4QiQNSrzzVCaUK0cZ9oKo17yBsUvYUWybFQMzGFiBKxu1+9wtlr+?=
 =?us-ascii?Q?HwU8prweMh5/YMwIhF4HcXFn7ruosnTH1ScUMB7brETYNk11pMJelgrsHxpC?=
 =?us-ascii?Q?7caam86nGJO8U2wBkCqTZaBvJxx2r+zOXYKqKbdIdcXwiYKK4vejLq3w2gNE?=
 =?us-ascii?Q?hnf1Vh8izz7fA6iGGQMYkII8hkDx3uEKg4aG148JDGfCSdYPj90sZ53LhgZI?=
 =?us-ascii?Q?bLwwcnPJlkqMWo3S61qA+kRKqF2lovx3qkj3fQ3BrU44FrSJuXuCxP+G2WvH?=
 =?us-ascii?Q?9T1MnzTCrXI0PuzTVjA5yopi3uY7lkHDAXL8g5m8c1FWGUKuvTL12kftqr9+?=
 =?us-ascii?Q?ubEyrHfzdc/T8mL7sgIWBPS3IlRlsJT02CXfiiFCpBprcGeNFOfyiW9XSwt6?=
 =?us-ascii?Q?RduOcDK3QbNP+6n2/ZZ0Kj1qRZ3A4PQQFdHGHgQ3oxj8B20n+V2kUZD1gsMi?=
 =?us-ascii?Q?DXcwjGrouNFLFmrzPZcVxNTfXSv6IsN8xdTlQ6Suvgnkl4fYmgdSTHKi6e09?=
 =?us-ascii?Q?qEiPrYIP2Yyb3kjjFZu6p7jySOFInBZAGKPlMmXNWsiwX19UCoS2MmDgLvg8?=
 =?us-ascii?Q?6a511MxiCp9SwD9isFFAKzmst4j5PIXs5DpW+SzTyLl1nzk2Q1Tr8TSHFKxy?=
 =?us-ascii?Q?KMRNvGnIbmy26fNim86+5OSnKonTRIMfYnFxwBjMgWbEz868Rms2UUtXNk0Z?=
 =?us-ascii?Q?WyJl+3nzzoOicLIOasRryy9ATX9Qma4uJiiO9Nt+HlmHykdujCqo6D+RmQry?=
 =?us-ascii?Q?2kLB1jMyI2bZIwzPwLXMiJhAYHclzbOxJQwFfif9QsemsDModJ2JMPlTVn9W?=
 =?us-ascii?Q?GWGdPqMZv5cFLrQTsM5+277W5yDTDK5gfnmmFEZGt/7azCx/C04XFca/B1NC?=
 =?us-ascii?Q?Ebd5zsQFnlKkkNJBQYwzLhVJBGV5+Fv5I4SmUwf6y/jNS447v99CfqYQUhyo?=
 =?us-ascii?Q?y2Y41x4NZundb1nvD159LiJ8zhy9qvgy9CIw9eB6Ybbi0EssCaNqut5BT4xD?=
 =?us-ascii?Q?E0MlTFF626XDTYZLX9VSqVkLe83yrpi1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CBw6OIyL2o4QD9iycpNX2uGmoTBCpCFeYaqB6tH+6iuhSPqkSgl0GCGjMonf?=
 =?us-ascii?Q?7za1bXDz3d8hVS3eqtJmn5brIXvHX3V/I3nVkB8JOMzmGpsRawn/h6GzChUU?=
 =?us-ascii?Q?g77DcVvmaMLIkOtBPijWvBADl4outSEn4JJta1Af+xEmMDSdKslT8ET5oewv?=
 =?us-ascii?Q?YVfm37QMbolqSeWSt/x+D2txeTU7D4T7RZKflZTeWlJUkKWFj8T3tW+5K4Bi?=
 =?us-ascii?Q?D/0vm54EJC2GkRHExHlCGYIW+uCq+fi9G8llupSAR3mtQoXHMcVBCKLj+FxC?=
 =?us-ascii?Q?ZU6LUbtwa+fZiodNDJSrKT1E+kv8dygKTdinCfkNQP+C5Hl/LPJuZn9A9/eW?=
 =?us-ascii?Q?JBvzLSop3qkAfzxXapcl84qN1IvjXSbiBJeSWVgvIbkNaLyfxJF41Ah1rZrV?=
 =?us-ascii?Q?oF07bjAEB9fiS9Bw0IVC8e5duZivYscvLUMH2ikSjLEWAdX69QLiTwVwIGow?=
 =?us-ascii?Q?bPkuaUVCnFNfnhQgaVxDrO9w16ko3cYcz6HM2XtKtwiE24mQmsZ5oVQc0cSR?=
 =?us-ascii?Q?krPnbUqLALAa1CKLfrWmH059c2GNMkSVSdwEOeE5DidbFlzVMsK6OC3utxMI?=
 =?us-ascii?Q?FoJNJ8QhYnD9s73iwZ6nyu8pWESt2NUUj9t71VIcM/klkm0Wl52Z8VTQ4Hlz?=
 =?us-ascii?Q?nBu+5/vAvi++drIaPZwcAb4vM9aM1nBxiXgGQQGn0mCbdUvuXa+MtNaJHUv/?=
 =?us-ascii?Q?VKFs3KRt/kUHj0dXWF5eTmzIPlC1tVnol9E3hGdx4Mu1Uq0Yy8zkb7g/5ck0?=
 =?us-ascii?Q?V2Xssg5umIzi7vyurKGxYBaZz0p7yVSmSG3wdzgj5ZtEJ4fko79tIxMRzL9b?=
 =?us-ascii?Q?kMfgv8jOsPAQJZk1HmMP1Z7ogL83jiS6YMCanDtgyOZaysc6MvyXUAGLVdLx?=
 =?us-ascii?Q?SD9AXFm5pG+kNGzl/FhF8UUzVRQMLxxrtNlIsJpDtmhSTYEeJMoctkG8BY0B?=
 =?us-ascii?Q?rvpf6nm6p+47y2g2GITEPTLfQ1RvWQ0Em90JsVKRGoyTRAQ83faCI4OAyoGS?=
 =?us-ascii?Q?EQnSZeq6Vk+QpsGVTSfus6P8g3UYfVhWHQdSKRLd52zpwsvyBfF9De03/erN?=
 =?us-ascii?Q?OwHTxpp/hpwaapGW6hnAAq6DvJ9G7MXWQbUQ1J4lia4zm78hjVIUeU3vxM16?=
 =?us-ascii?Q?OLqYk2crcrSEyK55SYK4duf8hfMICQ9SvEZhHKnkQW2dttpzWre3HeyS7e+P?=
 =?us-ascii?Q?o6E5ld+vuihScqNuWyNUt8Nkvjgk+UeaQfCtwMBhlMOHHlus5oFIuPhAAOBi?=
 =?us-ascii?Q?QTA8h+KfrF/OXoBnzsLNdKwJycsufBvzZ5OrTaBUItSr9jt/DWOqZwkSgcbk?=
 =?us-ascii?Q?kvYxYhXrDz1JD9OUr+GWkRun44Md7x1gGDyHNHeDY94g1sdG8p+U0IMBSqow?=
 =?us-ascii?Q?TjRMEEc7m5XpIovm4ZV/a6CmdiY6PbBV53z+JcZJmVJTE+O9aLdzR8ehoLl2?=
 =?us-ascii?Q?a8qCPlq3Q+xPxgX7B765gMBiJlxsI9+3J4jG2XJV6bwHv83F0fADuZE8OF6I?=
 =?us-ascii?Q?jphTc4OYFRbTdWEQWgr+l9kerRWD5C59AK2HnZo1VBILPHgQuyPqiYws3cCR?=
 =?us-ascii?Q?8zpZAEDvy1Ef9CzC7uxfolBb3B20YIvvpJn53cXK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ffa0c1-e34e-4447-dcd0-08de0b28e278
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 13:52:16.1977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KtBZ6NvMdTr3TCjjYwsxqGp6Li9X4ejvFX0VKhx1tXN2WjqewWPIKS2JHhQnwlolJR4otYD0hi7r6cLxbuNEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6568

On Tue, Oct 14, 2025 at 12:00:19AM +0200, Borislav Petkov wrote:
> On Mon, Oct 13, 2025 at 07:34:47PM +0000, Avadhut Naik wrote:
> > Currently, the amd64_edac module only provides UMC normalized and system
> > physical address when a DRAM ECC error occurs. DRAM Address is neither
> > logged nor exported through tracepoint.
> > 
> > Modern AMD SOCs provide UEFI PRM module that implements various address
> > translation PRM handlers. These PRM handlers can be leveraged to convert
> > UMC normalized address into DRAM address at runtime on occurrence of a
> > DRAM ECC error. This translated DRAM address can then be logged and
> > exported through tracepoints.
> 
> And?
> 
> I read all three commit messages to figure out *why* those DRAM addresses want
> to be logged. But it seems they don't want to be logged. Because there's not
> a single reason why they should be, AFAICT. Without a proper justification,
> this looks like a bunch of unnecessary code to me...
> 

Good point. I overlooked this myself.

The "DRAM address" helps memory vendors analyze failures. System
builders want to collect this data and pass it along to the memory
vendors. The DRAM address is not contained in architectural data like
MCA info, and getting the address from MCA requires using additional
system-specific hardware info. It's much more reliable to get the DRAM
address from the system with the error rather than try to post-process
it later.

Thanks,
Yazen

