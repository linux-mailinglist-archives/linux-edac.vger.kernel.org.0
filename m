Return-Path: <linux-edac+bounces-1909-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFAD97D633
	for <lists+linux-edac@lfdr.de>; Fri, 20 Sep 2024 15:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869DB1F22D56
	for <lists+linux-edac@lfdr.de>; Fri, 20 Sep 2024 13:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDC6177992;
	Fri, 20 Sep 2024 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dKApCcMV"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3F7158DB1;
	Fri, 20 Sep 2024 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726839394; cv=fail; b=XQDQj58mtcn6DVAA5PLF0iluq/+JehGsAmrbNyRxFZBrWFRpYgPo7XI+LxTRio1ch5H0jrFnq/Se2ZdVrMq0Cct1shtMir2Tk6agcJQlgYY2WnCdb0lot/Eu+iW+Io0DmUif2iBcGbExSZuF3GTrumXYrtUzLFWwRx1jWoyjjtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726839394; c=relaxed/simple;
	bh=H6kBHMA6ydGLylQ33Oyxu5smRQUIlZP39JdqErOD2XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=buIq5vXkZkny5DTPGqDBIFKuNC0U/NIjldkENlsMrsKajWc4T8IwwZrjx3xJLPrP9BlEWjx4mw5rBgc2HBdb/6djQwN84pIexD1Zyms4gzuaZt5/FlQ2GoiurEhAs4oZKUen38fXjrdTLzQMCu4E6nyu6+t9MOLhCS663bKogyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dKApCcMV; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oX57JEUWl+HY+ASslq/2LcSeMFGfdiOaXEJ/yfpU/VrkvasEhUf0qeRr3BJRg1xLan+c+UEk/5jGNuIdCHOyrPUDyfbc0ihvLaUKwcGu/Yh8nEvOnScUowAfEMMZpXLha/0lX+WBroPYxnGBqtUrWE6SjvXAm2tFNuUg2QuGkAdRFpuZZs8gUvy7wlfoK/O9cFdVIIjO+++bO/yfeXeTwgkns2/BMEKvZh36bqipgOF9e5xBz/KCgxHHjwrLoUgtH2xokS7iUksFMKiMaMzE3rsnz5WcgFcMkbq2D78MMb+9++ZZgGC+GrzsyQIE7Q3CAWs1Q0LS5jVoS4yw+abM6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hznJH5y9Q4us3KEMHHgKR/CRGEa8bmp7KBBi71O0Kk=;
 b=oYRB/OxZHZvKfgqaS9xmbAl3Prpvrj4KMC6Ztkkl3vUqzKCO/FKzaFe8Hb1eFcgcDzwhrspd+RT87aFeNv6n/rXSt2GPgLhiO+mjPyvw4985cH2zP+ohHejDD1ICmmB0LgNP/RHjvvUXusHbYIAVh+G9ctIduPiwVf8La7mKMIEtOKg8ukrw2HFCZqQBZ/Hzg7YZF26lTOZ1Grkc5eRAV+c3dG5faUI+NRBmp3q3yhpaO4kxUxYbts1b57huSWd8q2hueRQyR2BH3x6nSWNnZHerA+VSRb4A/GJyMovAkZZXu7WQ0bd4uPN/nGNrJmr3qraPH8xNpWs9ViU6FDxPQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hznJH5y9Q4us3KEMHHgKR/CRGEa8bmp7KBBi71O0Kk=;
 b=dKApCcMVHiENS8ZK80LPU06vitnEyltXB0XeXb95uUd5Sxalu4jkLP2y4PbIguc6mes/ZJVMF3laCBmYMV+QIRW5UpXnfuSHY0DiY40pkjJlxJrJqUubGcgu2n8qJMfx/8chWo9N3T2vm0r1pHJvyZZscPl6tDBHMpNbvlFfgps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 13:36:29 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.7982.016; Fri, 20 Sep 2024
 13:36:29 +0000
Date: Fri, 20 Sep 2024 09:36:21 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>,
	"TimGuo@zhaoxin.com" <TimGuo@zhaoxin.com>,
	"LeoLiu-oc@zhaoxin.com" <LeoLiu-oc@zhaoxin.com>,
	Lyle Li <LyleLi@zhaoxin.com>
Subject: Re: [PATCH v3 3/3] x86/mce: Add CMCI storm switching support for
 Zhaoxin
Message-ID: <20240920133621.GC286939@yaz-khff2.amd.com>
References: <20240910092652.13354-1-TonyWWang-oc@zhaoxin.com>
 <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
 <20240918055436.15551-4-TonyWWang-oc@zhaoxin.com>
 <CY8PR11MB71344BE2857EA522CF71DBA1896C2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <7a80b9f5-9503-45fa-bbf4-d0dfa97688ff@zhaoxin.com>
 <CY8PR11MB713412D068F202057A71CDE8896C2@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR11MB713412D068F202057A71CDE8896C2@CY8PR11MB7134.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0884.namprd03.prod.outlook.com
 (2603:10b6:408:13c::19) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|LV3PR12MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: 876b782d-afc6-417f-8cb5-08dcd9793bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S3to9YEDq3pz0rjfY+TPBs58Ii84DU6lBStSK+QllqNb7tfqbTnaiEtqbGJH?=
 =?us-ascii?Q?A6Q5BOpbs60HkxQ/0N0aTU1Qd1G8pGVQ0Zc9rEt1Zei+0MeQ0PFvVV7JY2uu?=
 =?us-ascii?Q?3StgkXKm4YsZaFTx3OcxFBaRAquJ6E1BOOSWM8ay4MFX4Tvh2ph98qlzTcEw?=
 =?us-ascii?Q?KDFrNXpB0cTi9CH8WlWlZKLSxrcZohSsG3NAWn8Zy7bUEwOWqRV3KJVV4uPv?=
 =?us-ascii?Q?GAwrXY3sZ2pukZYfnEAFs7OmcMt7rc1rbkjydBnXAj/gPdt/mTdNCyZPv+0c?=
 =?us-ascii?Q?CsRfcpjyisXIhDrE/ccGtni2Ug9fBlIOl68EzC/l7222ThfXnKkKeRXeBbhY?=
 =?us-ascii?Q?n+mlFI0ouY0zkPm6qPT8QWvk3fqU+37ZliBw3S9IZjL9XwY96hxz6J9NOE65?=
 =?us-ascii?Q?OOhYArC2jxOQxPDlNI7CCjbPeO6aTdR+X49baxQ6mhGx+BuohIe3xNOq4yI4?=
 =?us-ascii?Q?U7YvXtjXeOiXnxS6I0FBW9JM4j2K4/AY4FJTrsM/N6o7u+NA3JEXvjpAZqfB?=
 =?us-ascii?Q?jkI73QA4z0aBX93v3PceQgX7HPkGjOuIB/b39RueXt/udVSrA8pBc/sqcHZ3?=
 =?us-ascii?Q?Up/IXLEo7gpRyOIJ9+uB6kbycsqRglK7AOQ3C0pxQlEwL+otz1SKQy7TMEIB?=
 =?us-ascii?Q?0qEppJ2jKRWmKQGzHDrDQ/wolbk1e4Fq22TXpRExO3KYsLMcKnz5jb/FRWzC?=
 =?us-ascii?Q?X1ftq8+MrjYd0CRTgO28bvXPSe8sJnOtt9X3Jh3m9Pkvl41ZgQWkYUhMJF5N?=
 =?us-ascii?Q?LMLkaoUkJ1Ns+8f92hpE1EYN0SETWl/qkidTDj382cA3+gsM8fuCR73vs0S4?=
 =?us-ascii?Q?gc3vWk9U24Dfs0aRCPNf92tJ9lOvHtBBL4zov7lfRXZLdXpRo79b5Whkp6nI?=
 =?us-ascii?Q?y9CH3OtjAnmfOJMoA+mGurXgqsi6r8b3dNo9hcqrWNYmVpMb/g2YqxUlvycT?=
 =?us-ascii?Q?Vnm62lcEqWKDTzG+GJzMB2Q3O1FucVIpi2NtPqDUtbDyOZ2c1owa76OjjKw1?=
 =?us-ascii?Q?sXwRXqdw5B63e9ekWSkVoxbNLtyi+K+QNqI1tpglhBtMj7V44XULtEK253Bv?=
 =?us-ascii?Q?qZVkogK1QqusEgawOZO+x4IAQjTmMrnNe6mOVWsUfeA30londmADrdV2XpPC?=
 =?us-ascii?Q?acLn9hJgsyqoQFwUz/JLSwO0QN8ZzX0E3/jdWCOOucxK34K/hAWfWwo+wV7p?=
 =?us-ascii?Q?FTU7E/ixOxsDT/VjW94jy7ZGETL0rgqu1kMJ8UFO4N5Var5NlYs519hXy6yd?=
 =?us-ascii?Q?pcXcuvu7LWdgbwTfOunDqGjGcw0+n4H/vCumjH1x2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pCXHb2FUfTWKI9V4SVqZ6kGO+P+FqzPWPGNbG45icywJREotkMJ+ZoWoh6CR?=
 =?us-ascii?Q?IS5uCJjbOTLmBr7JRp2tI6hTX2i9PF6lVubWVUpe9M1NeYHNXKZnbRWRMEnZ?=
 =?us-ascii?Q?/9amwXL8eeseT59FjoSajeTw7TIKqr/SIP3QQdGIyZ17r64AITXT5cp4y2Fu?=
 =?us-ascii?Q?O3OgLBTXXa0LOWcxKdXAVQlRlG6nOvx5Modcimafnsd2q1+7bDnN/SuHcvIs?=
 =?us-ascii?Q?HjuinUG0kl83F1JFRYaLr4Epo26Jsk672fMtZSkeyqW52rWItijncgBMTw8Z?=
 =?us-ascii?Q?4uycMEoU882ZszsM9XRVQ2ZEsgFXwLwAkIx1AwcuiKrYwSL8vJcOp7ZeXw2o?=
 =?us-ascii?Q?kjW+Ta0jedk+YQ8sX9zijnjg79e1wk1uaHZ8LGCFRou+0m0UYU6/Uu7Fx2px?=
 =?us-ascii?Q?5EZdlFOK2bqNDsRZwus/PmxLEPxFKs9Bt7Gq7PmA7kJHcmwuR8DGP6CY4Bdl?=
 =?us-ascii?Q?AG1uai5b5iFjN90CiPsvWLeT9DRNc/ez9QMQxS6xCtOJ0TTQXBSKbiXVpFVI?=
 =?us-ascii?Q?HVKJWjG/5GMgZ7PVoe5OBGHAIslE/WFtSZHW+NlCd6987pJ/SPJO/xKDcvu6?=
 =?us-ascii?Q?IkcalRofNDGLJ7m3/BJr31/hsvX8By1gDT+AxwrUH9/ZX/NKTbovppmRAj2p?=
 =?us-ascii?Q?5zGcXuuM0IYiiVf3/17s/IS7Hv9V2yImIBsFJwdwzcMNLfwWKtFJTzjWu2qY?=
 =?us-ascii?Q?qD/vKIQ+Pl2LceEL7hZCgcIrpY/qw7D3KweFsGdBR+O3brBaCscF8bqLf24B?=
 =?us-ascii?Q?sf/DaKowD7KtRdzm1CGsI7tcmUQtEoGBfpqYhZv+77PbBwBgCYURjye7YweV?=
 =?us-ascii?Q?hUjwuIWkHN2pwqGl/vEGNKbp7loOMLD2QqSWckkIVhs/pR7vM6aIlpRQoDp2?=
 =?us-ascii?Q?0rGmTfVigRG+GRqA6W1Dtv2z4i06qN96Us63eZ6j4WfuYPAXLH+mws6JcTSk?=
 =?us-ascii?Q?1XQqVRSSpD3N2Zyd5COQHMU6nudURsnNJ9qejNUTqsRrdNHAYdEVNJoGf/CZ?=
 =?us-ascii?Q?89N5oSpyofDYzy1RGM2yLPRwBz/X5bK4upWqH2KbgXzOldKSSCRzzrJtl6u/?=
 =?us-ascii?Q?PbUZ7wQWcuF1siUG3bcqpJXiMRrKwbr61BeCMiMwPJJk09AGHQzlr8vx4PBT?=
 =?us-ascii?Q?9itdH7UFfdpPOsHObqptNdo1Ttpm3c90dY/+v7CBGUJLFRbLtK0hDhpeGkMH?=
 =?us-ascii?Q?xb0BL9oOc1a/IfRKSvjOKMCO5zQLwbs68KXTp4XFKw2eYWwtvEGHuSTbhzAj?=
 =?us-ascii?Q?yoqPUV9o9/dggziV1/GA9CQDKW42NGHF7rZWnFHZOQic2MD1fWqKEFy1j7md?=
 =?us-ascii?Q?hmAyz1fTIb2BUQb/oyeTPAsuQVVcL/U0SBlMUztD1ofpwHOHPuTjo0n8Fb7c?=
 =?us-ascii?Q?RySNH3SeAtjTsTtji0Y5Qniwy9r5Kb0p2LUmiGwvDbasgAzjzR6aQZe2WsnI?=
 =?us-ascii?Q?6O317GUGtdO5/udA+KBJ/vqZ2+YlE6HXbYS+j4seB/R6TlUvn6LfIdAjz1Mg?=
 =?us-ascii?Q?VpVU4f1xMcRURKnvESikZjc9g2Fsn2QZQHpnpQKZ1Kq1D8um0UIvq4sn3FRn?=
 =?us-ascii?Q?8dlqPJoOwdnw/UIPFDXQ/ityFlgGBedhibDJmeVP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876b782d-afc6-417f-8cb5-08dcd9793bab
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 13:36:29.7367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eS2oos2S1k2DpmFkwV42R7+Aj+bllzwp6T1NTfS+RmM6592yPKWG35a69eFgUtmGi+8PVDAzlBibNTO+xURPxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9356

On Fri, Sep 20, 2024 at 11:44:59AM +0000, Zhuo, Qiuxu wrote:
> > From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> > [...]
> > >> --- a/arch/x86/kernel/cpu/mce/zhaoxin.c
> > >> +++ b/arch/x86/kernel/cpu/mce/zhaoxin.c
> > >> @@ -63,3 +63,21 @@ void mce_zhaoxin_feature_clear(struct cpuinfo_x86
> > >> *c) {
> > >>        intel_clear_lmce();
> > >>   }
> > >> +
> > >> +void mce_zhaoxin_handle_storm(int bank, bool on) {
> > >> +     unsigned long flags;
> > >> +     u64 val;
> > >> +
> > >> +     raw_spin_lock_irqsave(&cmci_discover_lock, flags);
> > >> +     rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
> > >> +     if (on) {
> > >> +             val &= ~(MCI_CTL2_CMCI_EN |
> > >> MCI_CTL2_CMCI_THRESHOLD_MASK);
> > >> +             val |= CMCI_STORM_THRESHOLD;
> > >> +     } else {
> > >> +             val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
> > >> +             val |= (MCI_CTL2_CMCI_EN | cmci_threshold[bank]);
> > >> +     }
> > >> +     wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
> > >> +     raw_spin_unlock_irqrestore(&cmci_discover_lock, flags); }
> > >
> > > Are there any reasons or comments why it needs to disable/enable the
> > > CMCI interrupt here during a CMCI storm on/off? If not, then reuse
> > > mce_intel_handle_storm() to avoid duplicating the code.
> > >
> > 
> > As explained in another email.
> > The reason is actually mentioned in the cover letter: "because Zhaoxin's UCR
> > error is not reported through CMCI", and we want to disable CMCI interrupt
> > when CMCI storm happened.
> 
> So, this is just you want to disable CMCI when a CMCI storm happens. 
> This doesn't explain much to me.
> What's the problem if not disable CMCI when a CMCI storm happens?
>

A more direct way to handle an interrupt storm is to turn off the
interrupt. The proposed AMD solution would also do this.

Reprogramming the threshold to a high value does not 100% guarantee that
a storm will be mitigated. But this is a necessary trade-off given that
the CMCI is used to report other error types on Intel systems.

Thanks,
Yazen

