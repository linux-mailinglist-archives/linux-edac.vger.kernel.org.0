Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F2574290F
	for <lists+linux-edac@lfdr.de>; Thu, 29 Jun 2023 17:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjF2PEP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Jun 2023 11:04:15 -0400
Received: from mail-co1nam11on2075.outbound.protection.outlook.com ([40.107.220.75]:4672
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230525AbjF2PEO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 29 Jun 2023 11:04:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5oD3TU0NUl047Rb28gCxpb+sDXZoXIF5rXV393oDv2eu5Lpu7BG49yiiD2JkWQzbYsyQ07rVy0YPvqEOrcVkrH0Mq1GFkNe6uOdsdLj55qWWyCtehWmEHQhFd+C9bhl6Z2Jw6ntYbCUgRniB+3qP3QUgg5eP1iltBlZE9/JKSK7sIePEoHc4+bja6oaBR/nIMOGQ9p6IA6AjMhFL+5EBHLR6pNvIVRd/VqNQ7kWtbM2abgJQvO5YUZjLrRBnbdhNGk8of4ZXh8ipHXZCRkUbIyEmIb64WgBoPBHTz3KPBKMuh+tQPjwW5MhzQwsQAb7HMVFIcFbYOMFM49DqZCWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/uYJ62TdQ3XZr2iBhUFpJeYh6alcMhRA1gdnAN+3HA=;
 b=Et/HQemRNQTMBmKxb7n66I71iB5fnM7d6ZlUrXLzUmIlnK32AdKSlbi76mAxU6e/PCpknir2wveJIuTE4J5ro5bFS3NInMuzddF5WziCeBauLF7i/a0PxnTy6fKwfpJiyIraov55eE1vNF/91zqI50cuqtpSGr0gWTBdkG+rzHDE/u3dlNFux62MH7VgH5msDj1TsqL3b6H4KKimUXxxhpc8Ib4rqf2NDiCnfS2xcKVIoGMCffaBAxzKmYxUSFTDr24t/ZWCBwD2NXRWXqZIfYJBW0Ue17xk8DD1eM/vBe/e+P0As+aq52Lv9uPLqdN8FTKOOrK4il8QSF0KM6x0Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/uYJ62TdQ3XZr2iBhUFpJeYh6alcMhRA1gdnAN+3HA=;
 b=LbrtgqouuJH+F2LzEuWnXDS5Q6aQC8T0s4H3esCesriTv9CmlcFATXDq1perm4CUKtdHQe3r7v9vqdbg5IReJA1aELaG3SDXE4w3VKssWgUuPOzjV/3ebpgpRHGZskvNr3nMqyohXlThpT+3n7OO1H7TvPAz4aK+L5rd6FgN0DI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Thu, 29 Jun 2023 15:04:11 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::6ad5:3607:d622:669]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::6ad5:3607:d622:669%3]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 15:04:11 +0000
Message-ID: <8f445ff0-19c0-c2ce-2d09-cf8a5b9945fe@amd.com>
Date:   Thu, 29 Jun 2023 17:04:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Fix an off-by-one buffer overrun in inject_ue_write
To:     Yiyuan Guo <yguoaz@gmail.com>, shubhrajyoti.datta@amd.com,
        sai.krishna.potthuri@amd.com
Cc:     bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230629113933.4112456-1-yguoaz@gmail.com>
Content-Language: en-US
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230629113933.4112456-1-yguoaz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::19) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f81d74-c8ec-481b-a9a7-08db78b2184e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MTCAc1duVAoIlAv37+bc/1RhozmS4inVXdQZwMPJRxK1jg+cV4DZiGOzrPBC4i/eMTDF+zB6DBAef0EmD9Nz70PUEMG26i8Yq/2zNbbgsEJN7sCE2IBtxaYYZpM/SSF73kPUcILWSC1VwUDn+b5CGgY3nuwcbW/DQyrn2hBB340JyDR5Otxkdq4Zsj4Ady0G80uhHqJK8E6qSztiUFK51PvQXYhmymgN3vqWlC3T8xrVo02r3U8FWtfBnG2acJOS0cGF/vLhUjhMVALpjbENUBub7lD/G8VYl5dgLpeZQCtdxMtEgNBVudAco4bphDz/KLLp5r5uVvzf+u/CtMuTs59L6iLe4JRVRPtAj/6kgZSjHkrh6d7DCoAltOoJ++i2lIf9I7HfXCxmwpEcRLucTnij/K4Rg0L9BDaPfNCS/JXQmxWt/B2ksp13TdGLDeP6+mW1l3ZifF/TbEkCoKovON4/yXi2mbb32SPDJDGleeMQRkvlWFQhEupxZ0kVA3OJUdIcePluMu2wTKBFMcGe5onE20Eo2Nons3MCxjU7IXrED8ojOkX7nLHFlQaqKpqRA8njIcWD1HvV6sbBVCtZGYKzUwaab8rcgAMVu82OheO8EFgBYtAP2UBE2wrZVFTRBClBBrzdjEEElINsU0YDEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199021)(6506007)(186003)(31686004)(26005)(6512007)(6636002)(53546011)(83380400001)(2616005)(44832011)(5660300002)(6486002)(8676002)(8936002)(38100700002)(6666004)(86362001)(478600001)(31696002)(41300700001)(316002)(2906002)(558084003)(36756003)(66556008)(66476007)(4326008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S01VQ3J0MU1QWDlHZGd1STN4aU1sVWlNMlRkSE90Q1dmbnNYbmVhMGl1SFhT?=
 =?utf-8?B?MUx1Y2Y5d2g0N0IvVFlKbGg0MjRsZmxGWElFM0RCb041QzcrZWtKb3lOT1Y1?=
 =?utf-8?B?TEJJbSt6NVVicE16c2RBelpGYVhycjE3c2M3MUNvWWJUanhqREFnS0UzcElk?=
 =?utf-8?B?WGNaZU41M2ViTUF2K242VjY0a0JzVTkrWmhkSmp0d29tMThZSjIrZWZGOGFo?=
 =?utf-8?B?THZ4dlFjd1JhRWNPejY4WDZvSEoydTJzRTkwdExYUDJLcG1La2FtV1E3TXhh?=
 =?utf-8?B?OUw4aU9mVmVMZEFuazFTMERmMUs4aTY5MXpZMTg3UXRIWDlqQytWQVRFUTRy?=
 =?utf-8?B?QjV3UXFaYXdUQVZhb1NEYWh4d2ZDU0xNdEZyZHpmM0pVcXk4M3JIZmNmdGdX?=
 =?utf-8?B?cnl1ZEE0bnBDN2FKeVVMdm9TY25jdVM2emxrakJ1Z0xrOTJvMHdvRzZLQTcx?=
 =?utf-8?B?RG5ONndpdjFXZmpFSWhLNE8rcTlUMnZPSmdzc1RpeTI3Vk5kaVlaQUJQQ3VV?=
 =?utf-8?B?WkJxQ3B3WHZnVnJlYjBSWXBvMUdjeGREd2JlTWwveUNIN1JHWnF5Tm9yRzZQ?=
 =?utf-8?B?bGdaSE40Z1J0eDR6S3Y5cVNWaCtadUpKbTVvMlN4WUFaR2txdUpGRmJieFRW?=
 =?utf-8?B?aXowT20yeGVDKzRib2FwbnB0eUhWUm9kNEtLVkk3b3lZZ0MxQ2t1K1lPM2dl?=
 =?utf-8?B?Rko4WUNGV1dHU3pOV3loV3ZIZ3FXbU9yTUNQTWZOZjIvZzhJTUorYlZQMWNj?=
 =?utf-8?B?cVdNcTJvQ2o0WWUvRjNTM3E3WGh4eWxvQ1plc2ZENkJZRXEwQVEwTHRPYmhG?=
 =?utf-8?B?VGNITTA3U0xtYWlwZkJjZE9EZUlLMjNXRVV1QkdtZndJeXJrVm5ML3BVQVZE?=
 =?utf-8?B?d1RmUjRyZlVMWnlQa0UvUkMwUk1EalVxMTRBWmhOZzhObXdVRDRzS3BOd20x?=
 =?utf-8?B?VkIzQjMzdVhWbTE5ME9MRVlVWXBZV3pSdmZnK0cvdHViQUwrQWMxTkRvdUM5?=
 =?utf-8?B?eXg2UmVXZ2V4YVVObnhYWEE0WXc2Q2F0akJ6M3FhSFlocldaR0lSNzVUaWZm?=
 =?utf-8?B?YmpwL3JZZ0NuZGJFaWlJejE5V0lta1JkZGI3V1dibytLejR6UGpwYklTRnFS?=
 =?utf-8?B?YkdHQlNJRUJHWmdUOHg1VGxuL0MyblpReVdRd0hsZnp2ZmVLNGllNmdhb3VS?=
 =?utf-8?B?WFpuNXgrSEtjc1luL3pMdG8vOWZoN1ZTcW5SZ0JtZnhvVTZwakNXaWUybkF0?=
 =?utf-8?B?cjlQb1FZSGc1QVFDdlBQbSswSXQyNjIwUGtEUkNqcGUvdEc1dzJ1U1U4VDU1?=
 =?utf-8?B?aVRlRGNUMHpFQXJhS0FEU3U2SUpFL0QzbmozQTNYMk5PVjhDcU9qMjZIbDQx?=
 =?utf-8?B?Qm84eDMzZUJMQlpyTE9lUWFRa2M4dnU0aW1RQjZXQXhZK3VqQVk0cWV4OXhH?=
 =?utf-8?B?S1hqQktNUWs1VXpYcEFEeFFBR25Id3ltb3VadjhSTmtNMmFKbVIyanNzY1Qw?=
 =?utf-8?B?bGRpVzYxcVNSYXhVaGNubkFGaCsxNWRiMVFKQXFoWldSWVZXM2k3S1ZTdk80?=
 =?utf-8?B?MXRlbXUvVm9lOW9vQ24rdGFhWEtzcEZtREpoT3dpby9ZMVRmZ2FmWkFyV01p?=
 =?utf-8?B?Mk52cjFWVG02NW1HQjAxbE5jb2k2MXdJeTlseUhrbURPaEFBamtuUFBydnhn?=
 =?utf-8?B?V2lYdVE4QlJOYmtlNm91MjJ1d2drb1E5d0ZSOGdVcXhpbm03ekY0Y3N6NXVj?=
 =?utf-8?B?QjgzTjE2T1ZvRFlkQU9VV3BtYS9sMzh1V2FWWGVMWWJILzRpbGtsR1d5VFh6?=
 =?utf-8?B?aWtNcGZMNWxEUXd4Mm9jeGJXT2VZMkZWNE9xdmNSbkp0S2Y0UnV3VXhMQnNR?=
 =?utf-8?B?T1ZwV2ZEc1VwblhzY28vcGFjNUh2MGxJTjFML1RBZHZmdXBlVUUwSTJvUk9H?=
 =?utf-8?B?RHlaSXdmWG1iUndzRG1JSGFvQWxrS0RXSEZXRWFUQXBhRm14TjF0enh0ZlVv?=
 =?utf-8?B?dUFOYUVuT2ZQdWxvcExHR3dNRGZCTCtWWGdDSXE1d0pvQ0MxWlU2UmNGYTNs?=
 =?utf-8?B?T3U0WGFBZHpQREFaWFNtUmZkS0Z6dnl6MmQ2ZE1LM1NmZVJOM0QvVlhOalYw?=
 =?utf-8?Q?Mx26sc0UDl9KvW7LpwtpmXIVo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f81d74-c8ec-481b-a9a7-08db78b2184e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 15:04:11.3418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BuWN2TZrzAJA0VftuVdVEIT3k370OMHMCpEPrZBtUVNIS9vG1NijS2bfG2iBSON
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Your subject is missing subsystem. Run git log on this driver to look at style.

On 6/29/23 13:39, Yiyuan Guo wrote:
> Signed-off-by: Yiyuan Guo <yguoaz@gmail.com>

And there is missing commit message which describes the problem what you are facing.

Thanks,
Michal
