Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687EC417BE7
	for <lists+linux-edac@lfdr.de>; Fri, 24 Sep 2021 21:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344442AbhIXTsF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 24 Sep 2021 15:48:05 -0400
Received: from mail-dm6nam12on2042.outbound.protection.outlook.com ([40.107.243.42]:48986
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231756AbhIXTsC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 24 Sep 2021 15:48:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZnCF2QHxC+V+uCJUIkaOOD8ZlRX/5WoEfn0+wqyjlneJm1NdWXTdD4kpT8nerhGQK6NPwlUywccCS+sF+W3xRFVIeTi5Ihph3v30NUxQy4UQlon8IGHNDw4ye9Rkc100bUdsAIiP2pOs5lCAPg2rEYfY/lM6NeCuKmVqlrqVc1hPYtdHGlSD8vKvpSY7fCu/Ot8M1AQGcs+GnFI029OD9Frd+Do5lHX+AzRLJR8njcMUpvGQw/Bp50kcSzenVZZ9B6MtD7JvsiMgN4QkcK/Dn+mHGfNk0rQaQjARgXSxCWkIOjZHKzbJcTQGIHn+b8Y0VkPEHZ1Ynk7Igz48eEJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=N0DY9a5UDJO1L9jilBUBnphEmnTHQU1MNsnap5Fa2iE=;
 b=L2JUgDkIEB++f1dVMNSSTvN49wTVJMRKYXbvmfBMOqXPjxrYP8W19Dk0Kt2WV/1MFvOVbIaAnP3UsR4rXMcSXRSjxpoPC2yigUtrHe9Fq8R1r+DQJVdliBtNFZs5f5y+1UnjV24/7m18HDhl4VxZX6et5+QFxqk3G3cB89T8qZcwW0QK5uDVNEbReHnTgcSPwyAd7pQfByPqdEC2t0Pu5mTi9iYOj+aiISC1UzNgoJW9ebo0cdnxnylAJOmvsM+5NDeTMcOVtaWLvNdB1eUCcJfv8FlPeh1f6Xw0R7FcgX2IBXkFpkCyt60KIaPP6BTtZf/EtiE6r/riHqNAEX9SOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0DY9a5UDJO1L9jilBUBnphEmnTHQU1MNsnap5Fa2iE=;
 b=ka3AE9ATo/6nCxlw/GsQjecJ/FHdd+he0Et263eG228E4Xi3g2jAcyuCEQ0/Ea597UEnygtDRZ7dMpYNUJBe5QIQBnIDHZsuS+tJIJwNsPT9arEfpAGnpI1ZrdMWywJAUJlHSjNwvZvFhkR0FQFXRKC5g8PkAVAVIeM1SHzTxF0=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB2544.namprd12.prod.outlook.com (2603:10b6:404:a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 24 Sep
 2021 19:46:26 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::fd41:979d:a3e1:d958]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::fd41:979d:a3e1:d958%4]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 19:46:26 +0000
Date:   Fri, 24 Sep 2021 19:46:10 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Joshi, Mukul" <Mukul.Joshi@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCHv3 2/2] drm/amdgpu: Register MCE notifier for Aldebaran RAS
Message-ID: <YU4rAigWIh8g6iOl@yaz-ubuntu>
References: <20210913021311.12896-2-mukul.joshi@amd.com>
 <20210922193620.15925-1-mukul.joshi@amd.com>
 <YUyPM7VfYFG/PJmu@yaz-ubuntu>
 <DM4PR12MB52639349DF98DB01A3B155EFEEA39@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YUy4CdcUWJzQfM4N@yaz-ubuntu>
 <YUzD9wxtV411S8TC@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUzD9wxtV411S8TC@zn.tnic>
X-ClientProxiedBy: BN6PR1401CA0004.namprd14.prod.outlook.com
 (2603:10b6:405:4b::14) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
Received: from yaz-ubuntu (165.204.25.250) by BN6PR1401CA0004.namprd14.prod.outlook.com (2603:10b6:405:4b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:46:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2556098-25f4-4d8b-5e7b-08d97f93fe82
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2544:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2544DBD02B951B8ED56FD198F8A49@BN6PR1201MB2544.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GQNnJExxqAacjYcgsz77k9zuWIJEGMeNPTbLUhH+cGNPteb8r9J7GcXJCxh/lKn5jv7vgY1LdHJl4Ns+DPv1VCw7mJGv6mHXeXkCF9zi3pCelbOGTvmWemdjgOfioRYfC43neSaFxXGyM7y6RknBTPD319i/j9NP/jkr5ecyFnkzuxMhIxp/jbHse1SK9+KT3WaIYCuuWX/OW+gi64oEnUfd2Dy52g4/mLxUtJ0iuEBDEDLZWRynZb0gKydrOgtGdYlnhdBD1n6nmGBWxNCYJERxHHTN0sV/rdqF+d2N1LLOvIStjcvD/NFKviYbtDkMu4D4rvQUqsbDgIiVoDZSp9lmmH3l3RUg1WMKAtwvtsnazhAFvVxfXAwToXl0huP6DouSgBWqChNCR3FZvY+5baxMkzx2kiVS7gXYOFvUleeVQkNynxSfD326RrRJGGjkX0uO91qCA2IrfbnqSUZMCMmeELwNfovKBtShh9Sl81b4vYB6fxT0Gw3IELAsIh/JDKz/wR8FtTsbjqFyr5X0ZGn6LzqEI40UMUpu2SkhWqBwYgCv1xKRXlUjeKM57+haxGFRSfjyl/VWAt6LMuPTUq+PH+fNVrQpfVTAqT9b07EIkp5O/RcbBPOhAHy4ru/ReN2FEwcPz5KeGfPTUwPIMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(5660300002)(33716001)(86362001)(186003)(83380400001)(9686003)(6916009)(2906002)(8936002)(4326008)(55016002)(6666004)(66556008)(44832011)(26005)(316002)(66946007)(66476007)(54906003)(8676002)(508600001)(6496006)(956004)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HcDJ36iVi/k7Tri1MAdGbSO3DM6pKeIZwhDJSXFMUFlXFlh0qpWhFJ/q55sI?=
 =?us-ascii?Q?TIOZ/v1KUT2acaGNG5lFkOwPSer4esIyt8DMmOWW3AubgqzBRsSM9XCKPMrZ?=
 =?us-ascii?Q?S95r++JnoOd89MxOMwFDdGA8y7vKyhzgaUBRePsjkganwYjs3psRfAP54TFf?=
 =?us-ascii?Q?uS5CFQGo7WmJnWGSH9QrEuYLnTcWu+EsUIv7HdtEcbfwENBizecrmXvqWDMZ?=
 =?us-ascii?Q?Q/PaL0/v9YBc686KL8+nzdwhHP6RhKvL5nQhPmfaMSFDzRRbpTjU2bflDW3f?=
 =?us-ascii?Q?HSXMIEPaHTD/t6ACXP6FGFjfoZehGgsMkaW3aTz0oz39L0mLn389Dw7coxu6?=
 =?us-ascii?Q?MjmWZerGNCvZ93LRbuyauu0f4/RPssW+l8qyCsYCTrB8o8bsutn89HYAXGFf?=
 =?us-ascii?Q?uo1y021a4i5UXsmcQ9I759/Uz4jqPXjFwf3Fk6QuXINO0MAbi5C5L0gmimSR?=
 =?us-ascii?Q?3/+DKI0Gee61gyv8pH14bPBA3LTbJ/bn6v0g2oAZ59LAQBIVQKMEN1MGKHj/?=
 =?us-ascii?Q?bxwq8semAahbhyQjMsXW46zozEz4s+A+S7rmx4d3CVtfAS5T2zxR9YVbdVyw?=
 =?us-ascii?Q?DRYgTbGth1fnD0Y8YexwF0rAAty4QCoibwz9vz3fqGeJSLrligImxhHNdcVr?=
 =?us-ascii?Q?56e4+O03jw0IwbV/Z724T7sdSj3gevaYcdqV6sUyWgefshOt0EtVGbMQPDpo?=
 =?us-ascii?Q?v7TNJ3VGgArHM3AS2yXqhLNXMhSDznjF+YV+wuxVOT4vr2OP2mJ0RQu462h4?=
 =?us-ascii?Q?55Z5W9qkCt3ysQd6vrZIjCRGdliSCBH/fzfPhl7LL3K6DVijWJDN/cop2UJN?=
 =?us-ascii?Q?en1jOlR3TO4Y8wRQWbPhn27HU1OjeB+VChgLylsNKBbl+j5ZCITUUStLKOzV?=
 =?us-ascii?Q?E1BRqMMq/1lN0nghyNyooN66Gwxs7nn2ZSvT+jTqAVLYXsc5E8Qhbr1yLY4J?=
 =?us-ascii?Q?rGPFsTMIoc07+rjavtdj6wjMRPQ5VQQZOHWlifSKvFz5bKzvhpHgoJyJlYbn?=
 =?us-ascii?Q?FYjcWSUVkNzWXN0Pn2N8zLnMjDC7bU3EBiqJn4IIjp2/qBRmicMz1OPG2sW2?=
 =?us-ascii?Q?KnHf4NCNuCW+npxfPBu1pF6Lp3bSBIfoi0Oquy2bNgtbSka1uWPc4OdECQda?=
 =?us-ascii?Q?qQ6NLjjB82v3ZT7n/zHMXT7wxR2XoSEryevxwU4itzzhq+exjmjAWPsdflXm?=
 =?us-ascii?Q?uRIm5TGYUV4lR89dxbEAMdkKalzNBeaH0ulvpO8gt17gcieE4i3km0vugXtG?=
 =?us-ascii?Q?Ky3rA8k4u9fFKbU9GTojhYsXNyLQz1ECJ2VtddMIU0Ia2Xs7AuutCAERiiwz?=
 =?us-ascii?Q?32yQmbPCXsbeG5iCzqFSfgmw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2556098-25f4-4d8b-5e7b-08d97f93fe82
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:46:25.8891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1zoRczH6d3koLOjiB9oICxR9xacJeJqx7hnWZ4fPx0SIYlpOS+PW80LJKmN7RyMLoYc/vmKXir9febqn/rNRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2544
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 23, 2021 at 08:14:15PM +0200, Borislav Petkov wrote:
> On Thu, Sep 23, 2021 at 05:23:21PM +0000, Yazen Ghannam wrote:
> > Shouldn't the error still be reported to EDAC for decoding and counting? I
> > think users want this.
> 
> You know what happens with users getting ECCs reported, right? They
> think immediately their hw is going bad and start wanting to replace
> it...
> 
> So what does actually tell you if you were a simple user and you had 5
> correctable errors in the GPU VRAM?
> 

I agree with you in general. But this device isn't really a GPU. And users of
this device seem to want to count *every* error, at least for now.

> All you wanna do is play, I'd say.
> 
> :-)
>

Definitely. :)

Thanks,
Yazen
