Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D70D575CFC
	for <lists+linux-edac@lfdr.de>; Fri, 15 Jul 2022 10:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiGOIGh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 15 Jul 2022 04:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGOIGg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 15 Jul 2022 04:06:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB4E7E00C;
        Fri, 15 Jul 2022 01:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Su2ml//NGqQFLeOn0CLMxlrka3/4X3UvLTxtEK+absRuLqWKnHMu3hlf0QFp4ozXr0JAsz7NE/UFMUahkupd7aNJx93dSCxBJoX+jrsOvdYO6yKTTph8ytHdYPyVr/dY+CAuxBoxp21RjYBvpqTdieUkqAovkdPj7+xpoVyRmQgCWdjDVoiO1EjtHJQDBXAYEshDA2Lgmvw5cirrHUjHz3uztUFnXdObAEMyB1DvhGmWKZBiFtD+n/8vagvzWSI14U5zWMuuw0OQ5A01OtaKG41+xfmxp9rISE0kii5muc+2hXYEZG5nw59dHvhhtTGJTBLPzopyPG613loHoWGxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkLieEmu7/sA1axLo0voLQrZ/JfehGznPfDYEa5pAMk=;
 b=HUfhXfEeRhMBNTWR1t9VG9PEJllNT4xFvr2OhX+RMjbHHMx23B6xMUvu/TDsf9nfU0S5PLes9eRTWMRnBS953YED1nTNuJ6aTr2DrkYZ0XQ2uVdGDhXZBcoOijTj/SD9yyBkwCv7ijKEV9n0AT3FEV/R1Or42f6VafStm9J4rLxMZCaHNAsmu0ZMaRZtJXF440MUlghpBvCezs2QHNSyDM6aAlW6N5zBejc7O2n8GgwWcdzVOCPiJmgVWWZfbEwTcFDsWmoq0G0dvwTvaaON1DaMhHZxgQNESdMGM3uRWV31VxqVjraWE026NQQLggQYj+7mqJT9UnU3FhXJpG4aHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkLieEmu7/sA1axLo0voLQrZ/JfehGznPfDYEa5pAMk=;
 b=JBQAwO6IQJR4YqT5B/0QHIFH3XP8lWuOyXVI26jE1g1jW2gb717rbJEjirn/SJyscAgGNGVNsVODUwg0HWkf3WYUDpYJt7UchgjgVFr85xLahzCLjlmEHVLB3msat+9Kqe+IWCxBiQDofRHWAtA/XXZRq4GhXnpgoKGjZfpm+OrC6FAlh6Ho2ulegxoTe/JJhOdaHB+UmCY+O99PMHtSj0xzL2yopfeIN7QYJmZpLYvpYfShrLxemp/oGIR+F9Jf5XVIqblK/sOFWjl7ncGneoc+b7slWgub6bwYYkcHbSPs4QfwhRGTx0wAszOkLK/yOTDsMhRVLk1+Kq+F3O5Iqg==
Received: from DM6PR12CA0015.namprd12.prod.outlook.com (2603:10b6:5:1c0::28)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Fri, 15 Jul
 2022 08:06:30 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::15) by DM6PR12CA0015.outlook.office365.com
 (2603:10b6:5:1c0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12 via Frontend
 Transport; Fri, 15 Jul 2022 08:06:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 08:06:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 15 Jul
 2022 08:06:29 +0000
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 15 Jul
 2022 01:06:24 -0700
Message-ID: <8dd2310d-cf1d-600e-0bd3-7b16c7b4ac18@nvidia.com>
Date:   Fri, 15 Jul 2022 13:36:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [GIT PULL 1/7] soc/tegra: Changes for v5.20-rc1
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        arm-soc <arm@kernel.org>, "SoC Team" <soc@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>, <bbasu@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>
References: <20220708185608.676474-1-thierry.reding@gmail.com>
 <20220708185608.676474-2-thierry.reding@gmail.com>
 <CAK8P3a1bKUr77t9xkNAX=-RqzRme6Hymr3V=36MSHT_sOFEW5A@mail.gmail.com>
 <Ys6lXD6BSxjH02mW@orome>
 <CAK8P3a0cSq47B=acZ854TVu=RckJNfyfKdqQUMzCX7SsV7Wt0g@mail.gmail.com>
 <YtAajDYfcVHRGl1U@nazgul.tnic>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <YtAajDYfcVHRGl1U@nazgul.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9fdbb20-944a-4eab-136f-08da6638eca3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1NSR3RNd0FBajc2akZZK3RhTUVvN1JDRi9YUUpCTGR5ZlVpTVQrL2lYa2E4?=
 =?utf-8?B?OXRrTmpIOEI2dk05RW9nNGV3dk8vL09aVlpobWlKaStIakszZmVpU0xzaHB3?=
 =?utf-8?B?b1VoeDhlME5RbUZTWkNkcUJoOXA4M2hIWHR6U1lVVTBtaFFTVTE1ZmZIZDNK?=
 =?utf-8?B?bDE4M3h3R2UzcDZsdDZiYTUrWVhYQlk0cVBOTTVCWTl4cWhjRURjdURqcCs3?=
 =?utf-8?B?cU1FZ1BwSlM0M2dMUTk3VXF0WFAvZVJaU2EwOElaNjlnSTBQcnBoNWVhRTBt?=
 =?utf-8?B?YWdqdm5DUUViNE5aaDYxV0kyNFUyd1p5dVhmblNYWC9WYU5JQ1ZpWktiNTRR?=
 =?utf-8?B?cTFzMDJ1d1ZHUU1vczVQaHBBVDNjamNKbzdBdGlLVkFKMmhURm4xenBDdVE1?=
 =?utf-8?B?SnRuOUtVSUtNRGoyL1E4Mm1TeEFvMlEwc1NqK3Z5VWxFV1RpVk5NeTI5Ri93?=
 =?utf-8?B?NVZra1NuWGdUeXF4dkJCcXlUWHM1T3pnM0xRdHB2dmhxdS8zaFMrb3hHQzFE?=
 =?utf-8?B?Z0pLckRJdElRRkV5bW5RbEtOWEJFTS9LWkNqR0NCQTZDYm81MEhoSG9sZGMz?=
 =?utf-8?B?dkhRV3RyU0ExdzZRTWZwWmxObk1hbFhTdkNFNnc0SzFRVGJIaU1JQW4rT3kw?=
 =?utf-8?B?ak92bm8yYmYrNDhBZFdXOXY1RHJYdm9TQ0Zsc0huOTNZdFRiNjRvblVZRnJ6?=
 =?utf-8?B?S0p3TGc4N2V6c3QxM2F5aGRXbENzejA0M0tMem5RbXR5Vnp2K3k0Rklmb21n?=
 =?utf-8?B?Ty9XaHFqb2hPNittQUpScE1kWEpBODRrMUxYeUQyV3VRQlpoSU4zSXdFRU8z?=
 =?utf-8?B?QjU3bExmbWt1NUtXSmpmanpRejNJY0srdkMzMUJxcDlET2tGOVBJOUkrWWVq?=
 =?utf-8?B?dnNML0tDZHB4ZWtzK1N4RGdDQnJFaUpXY2M5MUtaa21VMHorQzFTL2w1Wkdr?=
 =?utf-8?B?RWgyV1ptdUw5WGlJKys5dll3QitXbWM5ZWg2Ynd2WFVqZnYzM1dXaHZXbkhh?=
 =?utf-8?B?V1h1Y3d1RExZYnVaVUNUZlMydkpzWGtqVGVWaG5uaFBIa1RYM2VSUWhtN2kv?=
 =?utf-8?B?TTc5TmxTZFZ6OTZPWW5sRmhySGI2NXZQRWdxL1U4aGFQWlQ4bFNDSGNyR0FZ?=
 =?utf-8?B?MDVFc3dxZTBjNVAraHNLTVJBb2UxRkxkQk9FU2ZsTXdRd09mdTJMbGlrbHZr?=
 =?utf-8?B?eU5WWCtiK01rWVNFTGI4UGxERHRMVFNOQkhNU3NMekRzWDZIM2VBWVljU2k0?=
 =?utf-8?B?Z0tqT2pXR2ZROEtwRzBzRDV3VTJ5eHNiZGZTcXIrWDk3bUtvdz09?=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(40470700004)(46966006)(47076005)(7416002)(478600001)(8936002)(5660300002)(81166007)(356005)(82740400003)(54906003)(31696002)(316002)(16576012)(86362001)(40460700003)(966005)(70206006)(110136005)(4326008)(70586007)(426003)(336012)(8676002)(83380400001)(107886003)(16526019)(186003)(26005)(2616005)(82310400005)(36860700001)(2906002)(6666004)(40480700001)(41300700001)(36756003)(31686004)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 08:06:29.9564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fdbb20-944a-4eab-136f-08da6638eca3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Arnd, Boris,

Thank you for your inputs.

>> I think this is just a reflection of what other hardware can do:
>> most machines only detect memory errors, but the EDAC subsystem
>> can work with any type in principle. There are also a lot of
>> conditions elsewhere that can be detected but not corrected.
> 
> Just a couple of thoughts from looking at this:
> 
> So the EDAC thing reports *hardware* errors by using the RAS
> capabilities built into an IP block. So it started with memory
> controllers but it is getting extended to other blocks. AMD are looking
> at how to integrate GPU hw errors reporting into it, for example.
> 
> Looking at that CBB thing, it looks like it is supposed to report not
> so much hardware errors but operational errors. Some of the hw errors
> reported by RAS hw are also operation-related but not the majority.
> 

CBB driver reports errors due to bad MMIO accesses within software.
The vast majority of the CBB errors tend to be programming errors in 
setting up address windows leading to decode errors.

> Then, EDAC has this counters exposed in:
> 
> $ grep -r . /sys/devices/system/edac/
> /sys/devices/system/edac/power/runtime_active_time:0
> /sys/devices/system/edac/power/runtime_status:unsupported
> /sys/devices/system/edac/power/runtime_suspended_time:0
> /sys/devices/system/edac/power/control:auto
> /sys/devices/system/edac/pci/edac_pci_log_pe:1
> /sys/devices/system/edac/pci/pci0/pe_count:0
> /sys/devices/system/edac/pci/pci0/npe_count:0
> /sys/devices/system/edac/pci/pci_parity_count:0
> /sys/devices/system/edac/pci/pci_nonparity_count:0
> /sys/devices/system/edac/pci/edac_pci_log_npe:1
> /sys/devices/system/edac/pci/edac_pci_panic_on_pe:0
> /sys/devices/system/edac/pci/check_pci_errors:0
> /sys/devices/system/edac/mc/power/runtime_active_time:0
> /sys/devices/system/edac/mc/power/runtime_status:unsupported
> ...
> 
> with the respective hierarchy: memory controllers, PCI errors, etc.
> 
> So the main question is, does it make sense for you to fit this into the
> EDAC hierarchy and what would even be the advantage of making it part of
> EDAC?
> 

I also think this doesn't seem to fit with the errors reported by EDAC 
which are mainly hardware errors as Boris explained.
Please share your thoughts and if we can merge the patches as it is.

> HTH.
> 
> --
> Regards/Gruss,
>      Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
