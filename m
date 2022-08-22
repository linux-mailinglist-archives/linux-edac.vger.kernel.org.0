Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C850F59BCE2
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 11:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiHVJb6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 05:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiHVJb4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 05:31:56 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D532E688;
        Mon, 22 Aug 2022 02:31:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqYOf2/5Fy0TqeSzk1snmKWN+W/3S3nppt80G7oR0IDEBd7mIn2c6/GD2NElffu9jFy2/Nj7rKUvc0+TZJ5N2uB1Jk57RVplDsgbz8wSLhzmginZF1ThxHTb7MAc1F3FLtXzw9p9FHE+JceDhJNueLkl1YeGue5Z0DDeynT7JUy8amOaylySW3VsCkmlwZgcjlEViYjgZ7MLwp0ROzzc8UaGM667SJOJtAT+jJUH/loDIHnoEAyNA64HptuZSHYYuGnXFyIa4GEG3mtQ9w82Cqo1RR4FByz+iGrZTJ9XcDJvckwT3aW3FxUPe6e+UV3e1iHki3m0W4Jh+aW1R/gRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXbCPNXNWdOsVsDuwZCI6LVbpYEJncVKQOWRB6zE9os=;
 b=cYE0QtB2RdwFpYIjp+UjO5+rrtXTgKCgl9hfm8X6wQtik0+mAoOHOaT/TH6qLyXXxVq2Zas0bl82Sx6eEwvSpVTqmyW1vPnqLDUncKiQbYMLeeNWHh6KeqSK92TfmzPeugbQufNQfKfP7x6gF/vO5pb1+rNttUdzJQLru8tQeOdO137ZFCtfzjB0Y217ojq6mkF0tYd3NcFZadzy3qvsD1eGs8G5R6mLC9OaHgMVv8LxJjNMKdKxuFR+eyiLXuLVD/DBerMDenq8VFvSc0+eoD2NHsS5KHiD2lukpG5Lqw5iR8qjn+hn2qubRWHi/omo7BFlCySqLNQPreV5BohLNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXbCPNXNWdOsVsDuwZCI6LVbpYEJncVKQOWRB6zE9os=;
 b=Hb8zZxCVjmAI0szs8hwSQEC4qun3/Jr55ZbLbiyHsBq1nVwhLH1SlnHm6Om3oawBEPAlcWTMLvnNDRBNtpNtFhEgc61GJBGKEhsIvoebz7fLlyay2x36MjlDqGMzMUyO3QOGJIMcEI0HcabxFBK98gJz64YfQAOkDqrF+rQootEMMDMtbiUYk+y5lAEl8xQ4FnMpAbzZKC2Zq/AmZo+Y+H9ZcAI9j+T9pY+91WqH/4rCK7CtM/FmoQGng7v7q8tBJp6i7TAxzxnZw0Npm/rexR172DK9x5P1gSDvN1LPy936T35n6ydg0WzpDqagEzMrPF/UcXywDO30K/V/6JQSIA==
Received: from BN1PR10CA0029.namprd10.prod.outlook.com (2603:10b6:408:e0::34)
 by MWHPR12MB1326.namprd12.prod.outlook.com (2603:10b6:300:10::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 09:31:52 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::6c) by BN1PR10CA0029.outlook.office365.com
 (2603:10b6:408:e0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22 via Frontend
 Transport; Mon, 22 Aug 2022 09:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5546.15 via Frontend Transport; Mon, 22 Aug 2022 09:31:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Mon, 22 Aug
 2022 09:31:50 +0000
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 22 Aug
 2022 02:31:46 -0700
Message-ID: <ccfb6de7-3c86-5ed8-801c-f8bce70997f5@nvidia.com>
Date:   Mon, 22 Aug 2022 15:01:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [GIT PULL 1/7] soc/tegra: Changes for v5.20-rc1
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Borislav Petkov <bp@alien8.de>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, <bbasu@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20220708185608.676474-1-thierry.reding@gmail.com>
 <20220708185608.676474-2-thierry.reding@gmail.com>
 <CAK8P3a1bKUr77t9xkNAX=-RqzRme6Hymr3V=36MSHT_sOFEW5A@mail.gmail.com>
 <Ys6lXD6BSxjH02mW@orome>
 <CAK8P3a0cSq47B=acZ854TVu=RckJNfyfKdqQUMzCX7SsV7Wt0g@mail.gmail.com>
 <YtAajDYfcVHRGl1U@nazgul.tnic>
 <8dd2310d-cf1d-600e-0bd3-7b16c7b4ac18@nvidia.com> <YuLItw2p9k4TgoH2@orome>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <YuLItw2p9k4TgoH2@orome>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 828cd0b6-41e4-468f-7ca7-08da84212527
X-MS-TrafficTypeDiagnostic: MWHPR12MB1326:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sp05VsyK/GVtwragXNJPvz1siLcZ5uH64RL7tFGtUCYWEUz2ng9ITdgSbgP1XDIrVPMctM/jAQXCZ9P/NJn99pO8NCnb6Iy6G9QfgMYjFdLJDaBgz+J2VetJRKE/VLCtN8h+IwstZUWM5ew8OGzdBC6YICLOpgzYamE5xA8UrigbTLiI/BJZ0tbpGnU1BDilLEQoYS9ZYvWto3I5lCXeJ5r/ZaIV3PHuILAkb8iJVoMcXlQmNxyS8xN0gJDlH8+m//zaf2f16M1agQWX0vOvjuSjKezWoNasomLFozFDe0ySZNyr40EZcUJeajIpldvdGI+Jhk595La7TDiBSZqHkcw4JHzVb80fcIY8mD2q+QtChWcJIZfmcBiZbDSxh58Pn2hkQccqWyMrw2IlOKJgqo206c15okHIbThdKdleu1CfHD3V9w8x6P/+FVnusQYOuxuMZvBhV2KVMnGLpoRpGaCMAqMbF+01tADZ9kuWfaR8bucrTyqL+qocshVn4a7bSIhjKESp0tevEev6vd2ul8dEdE5G8xlG92Jomrq9EoMjfbRNKvifm7tY9nGVqBrGalhC/IJJ03cT9K7Eke2DzMEXR8yxGoBiEQaoXzxKXOogNoDykZTrws01YOOOfvslKTPTxyZ6O90W01eOtAFXGls+JOWGCVta48QTB4X+PXii5N7mz26wUOYAYpfCfhAGHsqfhy2R8FFeOBVlBLHWUjTYNKqyHkAUR7T/xMor0Wba50A5edweIdkpdh64cYhTSGpDrj9NgWhuLI+/I3aMo4noAIDSUqKkGt6V5/nr0/hLKir6tZmBOb6B5g6bdUQ6Aw67N/ezCL4X8FAN0CQr2A==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(136003)(376002)(40470700004)(36840700001)(46966006)(5660300002)(36860700001)(70586007)(8676002)(70206006)(4326008)(356005)(82740400003)(478600001)(316002)(81166007)(6666004)(41300700001)(26005)(47076005)(7416002)(8936002)(40460700003)(16576012)(2906002)(54906003)(31696002)(40480700001)(83380400001)(2616005)(107886003)(16526019)(186003)(110136005)(336012)(426003)(82310400005)(36756003)(86362001)(31686004)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 09:31:51.6603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 828cd0b6-41e4-468f-7ca7-08da84212527
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1326
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



> On Fri, Jul 15, 2022 at 01:36:16PM +0530, Sumit Gupta wrote:
>> Hi Arnd, Boris,
>>
>> Thank you for your inputs.
>>
>>>> I think this is just a reflection of what other hardware can do:
>>>> most machines only detect memory errors, but the EDAC subsystem
>>>> can work with any type in principle. There are also a lot of
>>>> conditions elsewhere that can be detected but not corrected.
>>> Just a couple of thoughts from looking at this:
>>>
>>> So the EDAC thing reports*hardware*  errors by using the RAS
>>> capabilities built into an IP block. So it started with memory
>>> controllers but it is getting extended to other blocks. AMD are looking
>>> at how to integrate GPU hw errors reporting into it, for example.
>>>
>>> Looking at that CBB thing, it looks like it is supposed to report not
>>> so much hardware errors but operational errors. Some of the hw errors
>>> reported by RAS hw are also operation-related but not the majority.
>>>
>> CBB driver reports errors due to bad MMIO accesses within software.
>> The vast majority of the CBB errors tend to be programming errors in setting
>> up address windows leading to decode errors.
>>
>>> Then, EDAC has this counters exposed in:
>>>
>>> $ grep -r ./sys/devices/system/edac/
>>> /sys/devices/system/edac/power/runtime_active_time:0
>>> /sys/devices/system/edac/power/runtime_status:unsupported
>>> /sys/devices/system/edac/power/runtime_suspended_time:0
>>> /sys/devices/system/edac/power/control:auto
>>> /sys/devices/system/edac/pci/edac_pci_log_pe:1
>>> /sys/devices/system/edac/pci/pci0/pe_count:0
>>> /sys/devices/system/edac/pci/pci0/npe_count:0
>>> /sys/devices/system/edac/pci/pci_parity_count:0
>>> /sys/devices/system/edac/pci/pci_nonparity_count:0
>>> /sys/devices/system/edac/pci/edac_pci_log_npe:1
>>> /sys/devices/system/edac/pci/edac_pci_panic_on_pe:0
>>> /sys/devices/system/edac/pci/check_pci_errors:0
>>> /sys/devices/system/edac/mc/power/runtime_active_time:0
>>> /sys/devices/system/edac/mc/power/runtime_status:unsupported
>>> ...
>>>
>>> with the respective hierarchy: memory controllers, PCI errors, etc.
>>>
>>> So the main question is, does it make sense for you to fit this into the
>>> EDAC hierarchy and what would even be the advantage of making it part of
>>> EDAC?
>>>
>> I also think this doesn't seem to fit with the errors reported by EDAC which
>> are mainly hardware errors as Boris explained.
>> Please share your thoughts and if we can merge the patches as it is.
> Arnd,
> 
> any more thoughts on this? Looks like there is no consensus on where
> this should go. If it's okay for this to go in via ARM SoC after all,
> I could prepare another pull request including only the CBB changes
> along with some of the reference count fixes. I could possibly also
> rework the DMADEVICES dependency patch as discussed, or we could defer
> it if it's too risky at this point.
> 
> Thierry

Hi Arnd, Thierry,
Gentle ping.

If we are OK with the reasoning then can we please queue the patch 
series for '6.1'.

Thank you,
Sumit
