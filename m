Return-Path: <linux-edac+bounces-1908-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C59597D614
	for <lists+linux-edac@lfdr.de>; Fri, 20 Sep 2024 15:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34F81F24867
	for <lists+linux-edac@lfdr.de>; Fri, 20 Sep 2024 13:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6E514B084;
	Fri, 20 Sep 2024 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UEbBGaWp"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22041422AB;
	Fri, 20 Sep 2024 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726838609; cv=fail; b=CTAc6YQ6hXVdeZ6kQMAW/UowBcNwz6T0iTgBleSKSB1y5tRky7R9gJlfUD3qupRR5qOVHrXvqdM7KPX7xJh3u8h18W/a/pbc3NmIAkMGiq75BTDwOMdrpw2Pmlb1rbsj+f7F4KloolZWjN1vDkfbl/fuFwRKyJWUMrqbPKe/xs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726838609; c=relaxed/simple;
	bh=72yq/+R/jqdcON8krqPVjFps71eSUmDus+/YE9NIUeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZkGGpkxj1Q4t8KtA9FzjlDg8pscH129I+xAXIb7lGXrKuwq8DJ75s6fG1sBv0GM80ir6yYnOchL6UVWt+fz0z7djsd3/Bmh6KzVGLMwGGz5VNCEkl5ZwcS88xwn4Ct7iaEEwWb5ioI5VGra4XSsfm8pngtKbGefXyf/PdDrO+3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UEbBGaWp; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYyY1kzR9MKzkDBAgR03ZDaDjWG6AxlOfYt7rwGBvr8F+r6BkSAS29JjssxqFvy1zBCvaaA6LFsp4IYWhWGm5taz4OsMxXhoxamanSUCMjZm22NPar8U0cLTeeSeoHv7Mahp168tUpEjy7Xuyc+z/ScmOS3SCRgBzUDaZ6IFNxJ+5Z72BV0ztcGf0N5vs6VfhkwD7MZz897Xqrxn/hycH4ASuah1iGGMzQ2Ax/PiIwxBl0NtTAAm+7cobI/KHtQ1QGWxvkb/5PEv9a5q6Cx8ohDdHYLWeDZdFDDfyiVw5eUFLjFxkNajIi7sHEhSd3L1XDzrDQd29JBS0iKG2eWfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lR8LlS+Pn7N0AeWTZqx6vt57Qz/iqCMOvUxgGtJ7FtA=;
 b=LnBtDKRuxy3ZmN+7F4YaAe06CfQL0Wyi7/28XSlePGh0Vxwm7G2D1kbUr5Ymv0uCuaUHMmzFKXlFCw1l2igAnt9FBHrSgyG/7dFdMp+WgyXh1EyhGixtbnfA/1mLOmMYICxxnQ20Bht35oLN6W6SL8Qz/5HLfYXW3Zp4oCDo5CA1bfmnZ8KV6LcYSWlInyBpTEXtHnYJkWIvk6kMd5Ehnw3XN6wSNLfByFF4bfXGExnBSt/pp4DuBrynAsclBpXpF6XI6vpFg2uMzkBmcGlnIJJcJqlWIWAgzVeA6phUZkD44x8DNCh/kj2M0vVbw4W5wTb9cl1ZQytZPrDR3OvvEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lR8LlS+Pn7N0AeWTZqx6vt57Qz/iqCMOvUxgGtJ7FtA=;
 b=UEbBGaWp32FVApMxWh0iRZ77yRipY/v9GXxpUPqM3bVANGay6fMJVNS7nBg10KABwVXK1ZDH4vqmZ7A2AWt6gYleQWeA9BBKrK7aGfK2ityVlHx2wSRBnOAeDBdT5v+LZ0frWj9nVzEMyVtuT67UkQngxr0ZscGvZaJSCcUM038=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 13:23:21 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.7982.016; Fri, 20 Sep 2024
 13:23:21 +0000
Date: Fri, 20 Sep 2024 09:23:16 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	tony.luck@intel.com, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, CobeChen@zhaoxin.com,
	TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com,
	Lyle Li <LyleLi@zhaoxin.com>
Subject: Re: [PATCH v3 3/3] x86/mce: Add CMCI storm switching support for
 Zhaoxin
Message-ID: <20240920132316.GB286939@yaz-khff2.amd.com>
References: <20240910092652.13354-1-TonyWWang-oc@zhaoxin.com>
 <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
 <20240918055436.15551-4-TonyWWang-oc@zhaoxin.com>
 <20240919140623.GB3717@yaz-khff2.amd.com>
 <5fa3e397-376b-42c1-9dbe-891e9916987c@zhaoxin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fa3e397-376b-42c1-9dbe-891e9916987c@zhaoxin.com>
X-ClientProxiedBy: BN9PR03CA0760.namprd03.prod.outlook.com
 (2603:10b6:408:13a::15) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA1PR12MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 174af1ba-5523-4fb3-c07c-08dcd97765b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vjRInK36jRXQXkgbVFRx/LyaNFz/UYDbNbvqEGC95gyIV4GkpoxDMs+phaja?=
 =?us-ascii?Q?gV8GvI0+vs9lY8ubSXEc9i3bxbU1jxOKT+KodeeMT8WraYgejSNO3T049ZZm?=
 =?us-ascii?Q?l3CmfqvK2lzZ4eEsy7bMQeVsHBAREq07Qmrt4MbCXpDP+KDyx58EkwwKb/LL?=
 =?us-ascii?Q?fFn1o6T43xlfTKCQovx2ZFzXBtCKdaH13k3RI96JExqTdCvHO61sqkpSfGUQ?=
 =?us-ascii?Q?Y7Rx1OPm8uxg9GnwCJbvtGZylBX+ASp5/vS3oCnNtAQLSypi7PoBV7X7JKWO?=
 =?us-ascii?Q?htpPZCl/zEyL0H3QcMTvwswe9V/xtmf/6/qK//tpvmzdkJ9xp4chgULCCq8q?=
 =?us-ascii?Q?TkmUEzZV3ncN7V5GcsWsXkkWfx4KdKQVaX+dGuZlMQKQ92wxUAkAgCxa0Imt?=
 =?us-ascii?Q?390z9vudpHILIB0GmOtZnd6x6XJPYsZ5MlqTueLMaBhzcge1ZcRPM19Ibur9?=
 =?us-ascii?Q?KuE8ImHVptaFCn5wS9AqcSjUS/hWLVGdbk0QWcNYx32oukilPe5oQVpsIdNv?=
 =?us-ascii?Q?L/h2ACQn331Ab62gK+kywqBRhCQ9salnmHwRrLsJ0DkAJ01SbUHCkKqz7t1J?=
 =?us-ascii?Q?qfYckFj9hzNfJscgf4vB7osx4DDtyad+l/oAsJBiwM3oMD79b/mIKJlp/IFp?=
 =?us-ascii?Q?L6smTWhOO3sTtgbPtxttlvQM4RYnFxmMgP9EoRHbmq2xtLM4lM1nSyrRWsdF?=
 =?us-ascii?Q?LjPz68acwhqtpg1fEEUMtPiRzJ24xGQX0D+jFy4C3XzuSQQdtZwoJfc8n1lF?=
 =?us-ascii?Q?70hF/MZotM0/2IaCIV6c0LXxXRsT3HopDsjkdzctW5cFkVCPgP6V0PyJPU8v?=
 =?us-ascii?Q?ql+P8+1/RvG0PgGVeeJodLO9GKgkfW7w113MOuOj1YFVdNm6Omzl7pzvnt/C?=
 =?us-ascii?Q?vQ8YO9m49J6oO1gma/NvJ6ZZBRPW27pbGTARqDmQ0NR4tPbPYDuAa0cTSAsA?=
 =?us-ascii?Q?DeHsiE3NpxiKkVAE8+dvn4D9Y0UvsM2PYt92LI/bR2Oq8/4nmNCqs1Q7VCkw?=
 =?us-ascii?Q?xt7kQP98bMkStPvg23w4PHTp1KcSjCYvhUn7tbMhee3VUXsv7IAJUXc4BZoA?=
 =?us-ascii?Q?PPQ0PgJxTR92g697/Q/HYCl3OxpxT9edFWKwwag5OlygCrVoRy5CDdqPk1QD?=
 =?us-ascii?Q?Gbnb5ik6NfGQt05OID9XyHTNSsgMRH2aUtKE+TfssTgZlhbltImQFaB2Ltea?=
 =?us-ascii?Q?GPpc6qFCJiqulYmL8ry04gSp97qwAfbh/CtsEkgscpkJChCzN8w8Yd7xo3/Y?=
 =?us-ascii?Q?Lf9+aevcURKwYhA6ApDyKh3AcrC4MWBoqorxfPGG4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0oEGo+xpqwaPpju7kPHHkOcndNyZUnV2sW489GN2QQuTfibCMjw0Ds+1WUQy?=
 =?us-ascii?Q?rJJv3KoZ7l7ac2r/n4i2/cGwcWjNZOgC+SFh/8xbFnQRZxfTQyQnl6uK/xZQ?=
 =?us-ascii?Q?OEGWkKK8p6cmJGnMMG6Uw3VDTMZPvo0czBvtJXnz80k0nAAVk4oDHCI4T5HF?=
 =?us-ascii?Q?jpZoYJ30QQlVUJgNcmi4Mp3PS8Uk6Ey1gSWlkk+AhwpF0DylvJ9O7RLmWk9k?=
 =?us-ascii?Q?ymTr+vuYHHqUEbeuA9pPSbP+d6vJh3UGfcquMaidxGGNxdzMJ/6beSLq/VbR?=
 =?us-ascii?Q?qY6xaUGgYfdom73gfZincRHdRNOKF10wZJ3rm6YgnmMH1bjDpFQuXRG/ebPg?=
 =?us-ascii?Q?3ky3yswVt9Z+podoIkHV5nN1uf7rT4MEs1d+Cw2M9MsTOg33XEa/i9X37bI/?=
 =?us-ascii?Q?Wiv2fux+qbQdA8X0dqkKPNNqKELJhM979/OJuipBvHKdHyRs+yz8/wRy5yGU?=
 =?us-ascii?Q?O9W4PHzyj2CKI+HeLIzVBZxCu+Dx1SI8T/OozfH9KY8/XW6ZnfW8EJrYy3CK?=
 =?us-ascii?Q?pSun5gKThwbaNO8wbvogIBv3/Z+Gx+mNlhan2MqPVojjEhTRVaoKYE8X2HO6?=
 =?us-ascii?Q?qHweSmJPk8UxwaRbKOKj9W5yTsenciZ8dmkkSfRR0ECiAv9Hyp/UysJ7WmRS?=
 =?us-ascii?Q?FOm7bFLb8NEiU4cTSaaz28HWIJqpBq/X65NVc/fnxIv0eW6gVWkeH9txO11Y?=
 =?us-ascii?Q?GShsMGBmn3wQqXeBC6pJmwYBzKKGDTeFbY0PHiXyYMxciNvysNBQ36NmBqje?=
 =?us-ascii?Q?ZXpurr/Kv3IvMuizfJlKRq4j7y0SbSzMN78uecp7DiNO8TRYNXGWcZnshebj?=
 =?us-ascii?Q?thxLJ88Mj+d5VANAgrkzucmEuc8k/Vx0KmR8Bi2aE1Coxb93LViruWwcW8Qm?=
 =?us-ascii?Q?xwMt3DXU/ewoq4IKDCb11TtGopBvd3VUmbP2TYhIw8LwGyO+Drxn7vaRXnQ9?=
 =?us-ascii?Q?qPGx9tiNshXHBsWKI5KkTbpV7il3wWgR6ruU9nP92xND76WnqzpTBHfjAYhL?=
 =?us-ascii?Q?Vra83qcfGMvg86XGHn9N/H0xtcceLqg7j2CWIkdXMYYDEc4dmqveff0CGUCT?=
 =?us-ascii?Q?OuJ86pI51oFnPgcY+c1f50kqTKq03cz4J6KGqAZwYYsuUSOAWkjNR6jT2rcy?=
 =?us-ascii?Q?a09f4RR43YZkp5DL4X+NwCj7YBy47TGgY921gPcrzsixnr+c/tue0s/Sya6Q?=
 =?us-ascii?Q?KQRulN6wYsdYmMz/sSfyCbnbwdfNn2CnNjxmtfqXYDt8AbPUkzg78KLreRdJ?=
 =?us-ascii?Q?r3nvaI7SBi+VKcuY4jsaWoMxQiPc/aYe5Tjr3QFhJqcSnnVr/uS0fj0fXYQx?=
 =?us-ascii?Q?vbMR7E+xa/s4mX6AqGC2s05ygvtpGmmDprbsUf8jo5uZnWTSDrgVQVJmm1kS?=
 =?us-ascii?Q?OJ2ntDusHCZvT4znJOLR7hhT4tN3Qsvp3DXkwwwwUhWoqVVlwFP8hcUIkJ2a?=
 =?us-ascii?Q?juo/2fbQRPmRSxgGI481G0WKgc5ONcJkfCjwQwp9lpZwW/lmyw0zqOWnXEEx?=
 =?us-ascii?Q?4a/dmOOP5T6gm/jn4EwBo8YBUXCLXtSSE2XgMD/uuin5Q9euYE+WXNAvc2p1?=
 =?us-ascii?Q?Z6l2vREbCfH+V6Y9zpTVsa55UQPVpNmQkg64eF5R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174af1ba-5523-4fb3-c07c-08dcd97765b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 13:23:21.1436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfLYmR/wZ+y+24aG6e84ozfwOFwoTD0YUvj4vwc/8zmbwaJtp/MTqfAHVRbBloc8jtiqvs8F1YFnO3gbGtmn6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734

On Fri, Sep 20, 2024 at 06:42:15PM +0800, Tony W Wang-oc wrote:
> 
> 
> On 2024/9/19 22:06, Yazen Ghannam wrote:
> > 
> > > +void mce_zhaoxin_handle_storm(int bank, bool on)
> > > +{
> > > +     unsigned long flags;
> > > +     u64 val;
> > > +
> > > +     raw_spin_lock_irqsave(&cmci_discover_lock, flags);
> > > +     rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
> > > +     if (on) {
> > > +             val &= ~(MCI_CTL2_CMCI_EN | MCI_CTL2_CMCI_THRESHOLD_MASK);
> > > +             val |= CMCI_STORM_THRESHOLD;
> > > +     } else {
> > > +             val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
> > > +             val |= (MCI_CTL2_CMCI_EN | cmci_threshold[bank]);
> > > +     }
> > > +     wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
> > > +     raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
> > > +}
> > 
> > Why does this need to be different than mce_intel_handle_storm()?
> > 
> 
> The reason is actually mentioned in the cover letter: "because Zhaoxin's UCR
> error is not reported through CMCI", and we want to disable CMCI interrupt
> when CMCI storm happened.
>

I see, so you want to disable the interrupt entirely rather than
reprogramming to a high value. Makes sense.

Thanks,
Yazen

