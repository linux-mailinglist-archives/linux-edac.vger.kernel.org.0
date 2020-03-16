Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0DD187339
	for <lists+linux-edac@lfdr.de>; Mon, 16 Mar 2020 20:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbgCPTUd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Mar 2020 15:20:33 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:30819
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732383AbgCPTUd (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 16 Mar 2020 15:20:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVaXhSAgXuqvCCPEIhJVbObeX5ccqd3jwtIvUt7NqE/rKuQTGT4uZTU0D26DS30NeNQXIMrmSkedKbmtqedzaiHy+xHp7h/UQJxCCLMx7cvOyO6j1VRZbcMM2S7+t2aJNUJFVHeYCvNqZf5TcUIjJmFi/4g+xyacr/P6JI4dJxkX6Ub4Sj27Q4l0lWSPH+6JB9CrVdgW4TCqn4emSiEqs5Nx6IWpRTKKToAAGCXa9ngrmGrJOsnemXus4IQ6Rl4KS/cEhDmgPbp6pV65gOU2Vv5xXaDG+g8fWQepuJdNkunK2jqS+8Hs2qM8vz/Wx0YXTf7KD2oqBdNFw480I2d7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkbaULRPikhJCPpuOP/0Jf2Xd1lMeU4FYlqPjsxxBQ8=;
 b=XW7RIEvawhwpyrBVVyiZdl7AanMFVZsrq0xVLwIo5lWDyjo1zayqxh4VZ26bK3xP2DoTUU2qvwXzxEtlcmYbyg/jWBg76E5vR6QwFM255Q7t+xq/vibJjr2z0LIla+n9oaklVOqzpQ6H7SENwkP+9I05881ZmrAE7LrwB8KdncilLEYnlNv4tbaB4cjDmUUQqoBVEoWO9IrKKYYxe/EqMfyaKZeUYwZtjefXt0knlfzaTq9B4jB1YYTdGR/y4POfoO0KxYtaLzZcOblSDmdEU7+AWmXmTYBViYO3KJUCqbFc/HE7rUiAMoPjw1JTcrJf4pWCZQB91WAM78hm+PhzHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkbaULRPikhJCPpuOP/0Jf2Xd1lMeU4FYlqPjsxxBQ8=;
 b=ICNPxcmBq/TeneaYE0zgR14NQF+3I2CAWfzmtIOLkuAEOPVfKsPyL9Fh69BkOqMM1PNjk6fBU5KdA74EZ2NK4HHFM6YeTt2z3NDVCl8WAD9yKri3/OHfTA/xUNJTBdJH2hunfFrWBWfIMqOMsuM9NAzmdATpmQmUrqmLWp9yjsE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Wei.Huang2@amd.com; 
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR12MB1225.namprd12.prod.outlook.com (2603:10b6:3:7a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Mon, 16 Mar 2020 19:20:31 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::5d16:1d8f:9e02:9938]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::5d16:1d8f:9e02:9938%9]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 19:20:31 +0000
Subject: Re: [PATCH 1/1] x86/mce/amd: Add PPIN support for AMD MCE
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com,
        yazen.ghannam@amd.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, linux-edac@vger.kernel.org, x86@kernel.org,
        smita.koralahallichannabasappa@amd.com
References: <20200311044409.2717587-1-wei.huang2@amd.com>
 <20200316180829.GP26126@zn.tnic>
From:   Wei Huang <wei.huang2@amd.com>
Message-ID: <9d27e363-0c0d-cb49-4c2c-f84ed02f0573@amd.com>
Date:   Mon, 16 Mar 2020 14:20:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200316180829.GP26126@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0040.namprd02.prod.outlook.com
 (2603:10b6:803:2e::26) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.248] (165.204.77.1) by SN4PR0201CA0040.namprd02.prod.outlook.com (2603:10b6:803:2e::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21 via Frontend Transport; Mon, 16 Mar 2020 19:20:29 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f2f5e3b5-0f78-4e81-91b8-08d7c9df17ab
X-MS-TrafficTypeDiagnostic: DM5PR12MB1225:|DM5PR12MB1225:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1225FBD6FD44EFEFC1D5A7ACCFF90@DM5PR12MB1225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(199004)(66946007)(5660300002)(316002)(8936002)(66556008)(66476007)(4326008)(2616005)(2906002)(478600001)(956004)(16526019)(36756003)(186003)(26005)(8676002)(31686004)(86362001)(52116002)(81166006)(53546011)(31696002)(81156014)(16576012)(6486002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1225;H:DM5PR12MB1355.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N0IUjp1Cq9a7zBOgx1YMNseLCMOuKmcCsMaeKFxgQ6A4mZhW9xPWbRv8tLJngAD4jWUUUtrGf/OfpIusGh3D4RHCOdqPTlvJav8W1ddp2OKvzbW7VQXs17SGU8HUVBLL7Md6iiGxcnupEt0q/NLRoKpBtX1LuSsC9B5DP3+dqzAP4xyjpc9coa/p19h+eV3/O4k3tD0a1Vdm432UjyzqwNZp8eso1NAcEra/l8YTDYGY1H+p98tuLSkRGExuXQWk5pVn/amB4NXDntZ7VjlTLbbnqR8Xu5cAYekypcJts/mcIZm9Zh6AniBXQyOQg0d+WKedTqkUgjhjMCnDMYGeEvcCD1I4hNYnNo50sXDP4b0lm2gTlD+rq3iUV/xHVcN2xMTlD/UnsrULHlJ+lYFWhzFntnT4c4Gfr3kSsD04uSmJPS9QgAZodEGFPPXHqk95
X-MS-Exchange-AntiSpam-MessageData: eZ8cwbkPWsVYeEI7hSdi0ZI0jmoCAR2j2WLxWGV4Snf12eC8A+hN1TG0b1PECbt5vG/ZYPX3zwONYi8EorpZApgEvCmK38U6PGqwkm9bdVwdpIoCleoVNyH5Fsa/uDsZNvgXn+3zUDKZkW0RpC2rhQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f5e3b5-0f78-4e81-91b8-08d7c9df17ab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 19:20:31.0693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6U9RExydsjwWV0XEsTDUQEdCW0gBV47IZzkweqDzszXXbMf6AUUJ0NIC8JtzB87
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1225
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 3/16/20 1:08 PM, Borislav Petkov wrote:
> On Tue, Mar 10, 2020 at 11:44:09PM -0500, Wei Huang wrote:
>> Newer AMD CPUs support the feature of protected processor identification
>> number (PPIN). This patch detects and enables PPIN support on AMD platforms
> 
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
> 
> Also, do
> 
> $ git grep 'This patch' Documentation/process
> 
> for more details.
> 
>> and includes PPIN info in MCE records if available. Because this feature is
>> almost identical on both Intel and AMD, it re-uses X86_FEATURE_INTEL_PPIN
>> feature bit and renames it to X86_FEATURE_PPIN.
> 
> Strictly speaking, you can't rename it anymore because it is visible in
> /proc/cpuinfo and thus ABI.
> 
> Besides, we have already a cpufeatures.h leaf for exactly that word:
> 
> /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
> 
> which means you can call the AMD define
> 
> #define X86_FEATURE_AMD_PPIN               ( 13*32+23) /* AMD Protected Processor Inventory Number */
> 
> and /proc/cpuinfo will have "amd_ppin" and the code will use the
> respective vendor flag to test.

Thanks. I will send V2 with fixes based on Tony's and your inputs.

> 
>> Signed-off-by: Wei Huang <wei.huang2@amd.com>
>> Signed-off-by: Smita Koralahalli Channabasappa <smita.koralahallichannabasappa@amd.com>
> 
> What does this SOB mean? Grep Documentation/ for "Co-developed-by" in
> case this is what you're trying to express.
> 
