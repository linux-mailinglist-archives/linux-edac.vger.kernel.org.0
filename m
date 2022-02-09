Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1A04B0063
	for <lists+linux-edac@lfdr.de>; Wed,  9 Feb 2022 23:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbiBIWe0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Feb 2022 17:34:26 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiBIWeZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Feb 2022 17:34:25 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404F3C1DF65E;
        Wed,  9 Feb 2022 14:34:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ys5ebsQ0L4mwcomoy86xNzzyeAtBA6p/BOcRyCQrMwi/xcNJ/ql0Pq+wudOxTOtIC1kXlAy5DW5sbLi4ZR82lBEuQS8Ms/pRwQHVOYaxjx/oFDT3pIn1cnett+yUZVzUZzuMJ4K7NoRYr22u28phX5Edb1p8dp4jENhUp/1LapoFJ36pOHI8LcMHvxFOV1I44/+unSJCCOzSMD09/bWFG6JEjXaQ94f0/da0tRBRFoXh1q9oKqUDDizpeHY+q9Fz30GqMifOll1KWY0x+ncbC4XueinDhnUdP2chze1e3h1VJdoFFOArozSqjVPKyA9gOVBPjfz1igDe+Z5nbsclRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2cAgcK04+41vR2JRaKYWiwxOBIhea1G671y4CMEfp8=;
 b=eg7faP64SSq0NbvsJJDYhCY1xkSQiY3G/Nwh8/9oZXvhkWBus+bEp9aFjl0xXm1sAuyjarJkQv10FHyPFqJlkdsNyLXVd/bAQVMDv1//VVa1cgdQuwmgPWFV+G9S6sl6u09uInmAdhf+PIQ+Q9UFyBm22DwP2RkjiTSYzW49bQN5FjMngoj43Gv9XhEJNqCNsqCoc7ifTwQ2OMPlzRwHR52U6f+lzGXu7fzivhXyRUyNfZn6ozfvKV+nrNCjzzOLWyexczBy8YlAFsgsHW1/fj/jAvtW/a9EZOYH0FKByhOoT8/Jmu5E5krZvRRVA8oVXUYy/8dqPxqfGychFlnK2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2cAgcK04+41vR2JRaKYWiwxOBIhea1G671y4CMEfp8=;
 b=DNQxEuKHTT3GVgwdya81seQmR5LEZv5cQ/gskJjG5QPDwwXc6Vm2UjsRe7GwOR86ZIdS7OTTMkFkcNthKvJcGEyrA/NE1AsS3MJFBvXJGIv6gH2uRk6ugrfpedCyd+8OTd+sPzG1yvBfXYH5EN/lV7L4rDTBv/QhAm8TwReMjCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 22:34:23 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a%6]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 22:34:23 +0000
Date:   Wed, 9 Feb 2022 22:34:14 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v7 01/12] EDAC/amd64: Document heterogeneous enumeration
Message-ID: <YgRBZjUN3AoHr7q+@yaz-ubuntu>
References: <20220203174942.31630-1-nchatrad@amd.com>
 <20220203174942.31630-2-nchatrad@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220203174942.31630-2-nchatrad@amd.com>
X-ClientProxiedBy: CH0PR03CA0355.namprd03.prod.outlook.com
 (2603:10b6:610:11a::12) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ac51102-9607-4178-0c9b-08d9ec1c5269
X-MS-TrafficTypeDiagnostic: DM6PR12MB3963:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB39638BA15D2B9ACC9B75F249F82E9@DM6PR12MB3963.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPQ6DUNhr73H4ADX2rXxbSHa2Y1migK2PhQl0ff0n8vsti3AJA4zZ4ML2lVXS16gfY3ltZjk3PK62jrkcCeejsJNYY4SDC4Z8/eNMBJBXt49lymb9OqPyFSxMeTmVHsTa7GkbiyDO6dv7O32l6zx4xLpYTPTzYLoWTSRaumPOKFTDtbVAUjQiwNikwkEP+48oxcB9mtOP5DrT47CI8FC0rIGpOvTspFpemzshtpqtCnlu9b2E3U0bB2xoCuGn1OUpXIN4emPvh+xEyEcQMvtc8QMoEZx0PXFB2ANLQOCTFuQLqfL+J6YhiqnT2Q0pbaeJA2iKV86OlU64EiyCOzZgVMJSTvEphAtXKuo2NYMRdpYlmGu46W+KDqvpWELDw5fJE5mVILXJF9EWbUjjizZ7Y9/Ynb/gEstaza+kFpbffAuLMwXfjLmDIDOrpFHoBnNsDRkyO5yoxN6TApZeSXCQfzd1G233kH6UAq9kjw8KqTCIxjE2tUWomiRzkX69UuxFl0YklnOD/7q1X9SyNiV5sLaKLtZVLd5h+pgbo2iusknxGGPIIr8s8XL8gIXkUg2U6bssoAGcHKUnPDvP9IxSn6xSFYs0qjV1+9Niji2H8rDv6kPJTb3tCTkmP2pPMLgMTXWh76kEZw6/W8MrNuQAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6862004)(4326008)(6506007)(83380400001)(66476007)(9686003)(6486002)(508600001)(6666004)(66556008)(8936002)(8676002)(38100700002)(186003)(26005)(6512007)(316002)(86362001)(5660300002)(33716001)(44832011)(66946007)(2906002)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWpmWTNoM3BqS0F5bDhMdkRralJpbG5PZ2ZrY2xQdVZMQ28xZXczNUNIVk1x?=
 =?utf-8?B?aWk4WW5OaFRhQUo2dmJxSjFMR0lPdFlMcHhSRDJCQlhJdGwxa2FpdFliblV6?=
 =?utf-8?B?S3QzV0NZZ2dKbURCWGZqM0l4bFYxY1FPVWxmQ2J3YTZkT0RtWXJIaGtXM2ZW?=
 =?utf-8?B?d1pwcEpCNTJuL2xDSndMUkMya2NtZkRIQkFWa29YRjFrZk9aYlJLSjYvaXQz?=
 =?utf-8?B?SC9udWp1ZWFMYzdVUWR1TWFoVy9yZ0s0alRQUEZ1M0h6NjNRd1NmY3F0VlBC?=
 =?utf-8?B?WGNFZ0daTTl4d0poMWxjdzk2VS9Pb3ZxTHRBcEVyakVOMlcvNC9CWUZWNHU5?=
 =?utf-8?B?MWNsUmVnU2dhMVA3MzVsTmFJcTNGek1JMHp3VkNVYXUzTk83WkRvTzJJTnJh?=
 =?utf-8?B?TlhSUUVFZ0xRYVV4M0VGeWozdDNnVjEzZUhYSWRWRGp0OVgyQ2F6UTdMRVIr?=
 =?utf-8?B?U3FiNmg4WUxvMmdYdGRlM09qalliakI1YnNMYWZiZkhTL3RGR1EyZ0hFbjRS?=
 =?utf-8?B?TnNOd2FaTWdWa1ZkVzhqUjF4NTVVdFE1VTUvcDR1K2Q5RXRDWU9ZN0h3TzZn?=
 =?utf-8?B?a0s1SUNXNXhoWDVWVWVlZjJFOVBCTlgxV2l4RmxEUWRNUEVPcEs1NGFzbDVo?=
 =?utf-8?B?WXIvUlEvL0E3SW5ySXhLVWxiZWRWV1VudzJLVTRvcDRIeGZ0ZGgyUWlPY1Ft?=
 =?utf-8?B?QnlXbnNZMER2eHhYWWZLTTRuaWRUbjlubVkrOThVMWtDRjdoMnA1N1M1UkRR?=
 =?utf-8?B?VW9NTHJ2bjJaMWxvTnBISXFiaW9sSEQxTzFJd2M3QkZNYWlpN1hsODZXRXRC?=
 =?utf-8?B?Y0NOMjhvcld5VjBsd3d3dXJkREVsWFVWcnF2VkVISU9LVnZidk5BYkVpYnlC?=
 =?utf-8?B?TFlsQ2JGTUlyTXU5eFR4NDhkWFYzZGhoMTNJQk9LTWlrNFlLeXBIV2M1WGov?=
 =?utf-8?B?N3U4TnViZmVidlQ4cUVWSGVjQUVmT0FvbUh6alI1K1o4U1FwTjRCTXRpV1Rz?=
 =?utf-8?B?UDV1UjdheUx6K21FMWpUMG1jMXMwYTdGa0NITm1wa1FzYk1EZEdxTXhpNkNP?=
 =?utf-8?B?bTlkWDd1MmlHeUg5RTZrMFF2ZGQxelFuWnRrcW4wTzhveUk5ODVVVk16eWFP?=
 =?utf-8?B?WSs2bzl2Ui8xcy82dTA1eTNBZCtpYjhkMmJ1ajB2OHBKYzRVdmxjejUyUW1D?=
 =?utf-8?B?aGt4clYrVXJ3N3lUbTg1dS95eDhha0htQ3pmQitnM3F2RFU0RlRFTmhKNU5J?=
 =?utf-8?B?TmJKbHFiNVhVREhQNitKbnhJWE9laXovVmEvZHNEUk9UQUp3WHRPR3JrUTFi?=
 =?utf-8?B?MWxlczNFWm9iYVd0K1F1Y1kybWtYR3FvRlZYczNyYzdOUVZaOWZQWlJPaVly?=
 =?utf-8?B?ZUNTMkVUNmlsR3F5NDljWFp1VitIaWNMRXpPOTZ0QVdsckQ5WnllUzh4WG5V?=
 =?utf-8?B?M1BGWVJ5MmVtaFc0OUYvR2JGbm1kdmdpVUx1dFhyaEtWaFQrZ2pYNFpNb0lm?=
 =?utf-8?B?VFgxaWlxdWNTZkdTT0pURUdvUE5vcUdOUkx5dUtGb3lMcjFhcEhOMXdGVGlF?=
 =?utf-8?B?STFGLzlQOEUxRUd0NzB0ekdudkU5d1FwVFBBQytYV0cycFBLMStnNHlaMUNv?=
 =?utf-8?B?MUJZY0dVYlovckhmdGUxdUYwYm04OWs2ZWpqNEFxZ0xwRTlqdHk0NzRScVQ4?=
 =?utf-8?B?R21zNlNsZHVEcXQyVWhYQmZIc2k2YWZvRFFFclNabkhWU3RVR3dOVUtIYVlt?=
 =?utf-8?B?Q08xZzh4SG9PbUxtQ0pzRmxZbUpsSGVFdHRnbVQ3azRjVVdSbkxGc01EeXlQ?=
 =?utf-8?B?S2F5NVpDcG9XSUtFdDZNQ0dneHZ2TzVvT25DNG1uOFZmeHhNY2RCSHBIVHpa?=
 =?utf-8?B?VXVFUDZKRTdpRGlFNWZhbWRhOTdmQkZCTTFLekg4dkV2MUg2QTR2cm94MWpa?=
 =?utf-8?B?QWY4QUQvdUREQlNXQkhPbmo4aUhDeUhvV25lQm5TZjVDa1JYMHkyczNEY0d1?=
 =?utf-8?B?aEhSaWNncHFidHhqYWFBR3pJOVh3QnJLVzlBdFBvVFFRK2xieXFZU2NPeHo3?=
 =?utf-8?B?WHNKWUM5WVRCYkRvc0NtVTNxZ1FaZ015QkNBaEVIMHd5L2tQQWdDT2I3ZFVU?=
 =?utf-8?B?d2FhVHFoOWxrcWNHRTFmaGdYSHFEeFVqRnpqTGRUYUZMMjltcFl0a1Rja1Ra?=
 =?utf-8?Q?OlCZ6y4D9eYBh3tQfL8AYUs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac51102-9607-4178-0c9b-08d9ec1c5269
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 22:34:23.7991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hQ3rLtoP0QDjuL8eeDF5UO/0J10jRZR/l3PfnsM+/2Y4thdVxTUYsYtaOpbESOrCq08hSKflhGd2QiN32muSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3963
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Feb 03, 2022 at 11:49:31AM -0600, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> The Documentation notes have been added in amd64_edac.h and will be
> referring to driver-api wherever needed.

I don't see the comment in amd64_edac.h referring to driver-api/edac.rst. So
I'm not sure what this sentence is saying.

> 
> Explains how the physical topology is enumerated in the software and
> edac module populates the sysfs ABIs.
>

Also, please make sure the message is imperative, e.g "Add...", "Explain...",
etc.
 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
> v6->v7:
> * New in v7
> 
>  Documentation/driver-api/edac.rst |   9 +++
>  drivers/edac/amd64_edac.h         | 101 ++++++++++++++++++++++++++++++
>  2 files changed, 110 insertions(+)
> 
> diff --git a/Documentation/driver-api/edac.rst b/Documentation/driver-api/edac.rst
> index b8c742aa0a71..0dd07d0d0e47 100644
> --- a/Documentation/driver-api/edac.rst
> +++ b/Documentation/driver-api/edac.rst
> @@ -106,6 +106,15 @@ will occupy those chip-select rows.
>  This term is avoided because it is unclear when needing to distinguish
>  between chip-select rows and socket sets.
>  
> +* High Bandwidth Memory (HBM)
> +
> +HBM is a new type of memory chip with low power consumption and ultra-wide
> +communication lanes. It uses vertically stacked memory chips (DRAM dies)
> +interconnected by microscopic wires called "through-silicon vias," or TSVs.
> +
> +Several stacks of HBM chips connect to the CPU or GPU through an ultra-fast
> +interconnect called the “interposer". So that HBM’s characteristics are
> +nearly indistinguishable from on-chip integrated RAM.
> 

I think this makes sense.
 
>  Memory Controllers
>  ------------------
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 6f8147abfa71..6a112270a84b 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -559,3 +559,104 @@ static inline u32 dct_sel_baseaddr(struct amd64_pvt *pvt)
>  	}
>  	return (pvt)->dct_sel_lo & 0xFFFFF800;
>  }
> +
> +/*
> + * AMD Heterogeneous system support on EDAC subsystem
> + * --------------------------------------------------
> + *
> + * An AMD heterogeneous system built by connecting the data fabrics of both CPUs
> + * and GPUs via custom xGMI links. So, the Data Fabric on the GPU nodes can be
> + * accessed the same way as the Data Fabric on CPU nodes.
> + *
> + * An Aldebaran GPUs has 2 Data Fabrics, each GPU DF contains four Unified
> + * Memory Controllers (UMC). Each UMC contains eight Channels. Each UMC Channel
> + * controls one 128-bit HBM2e (2GB) channel (equivalent to 8 X 2GB ranks),
> + * this creates a total of 4096-bits of DRAM data bus.
> + *
> + * While UMC is interfacing a 16GB (8H X 2GB DRAM) HBM stack, each UMC channel is

What is "8H"? Is that 8 "high"?

> + * interfacing 2GB of DRAM (represented as rank).
> + *
> + * Memory controllers on AMD GPU nodes can be represented in EDAC is as below:
> + *       GPU DF / GPU Node -> EDAC MC
> + *       GPU UMC           -> EDAC CSROW
> + *       GPU UMC channel   -> EDAC CHANNEL
> + *
> + * Eg: An heterogeneous system with 1 AMD CPU is connected to 4 Aldebaran GPUs using xGMI.
> + *
> + * AMD GPU Nodes are enumerated in sequential order based on the PCI hierarchy, and the
> + * first GPU node is assumed to have an "Node ID" value after CPU Nodes are fully
> + * populated.
> + *
> + * $ ls /sys/devices/system/edac/mc/
> + *	mc0   - CPU MC node 0
> + *	mc1  |
> + *	mc2  |- GPU card[0] => node 0(mc1), node 1(mc2)
> + *	mc3  |
> + *	mc4  |- GPU card[1] => node 0(mc3), node 1(mc4)
> + *	mc5  |
> + *	mc6  |- GPU card[2] => node 0(mc5), node 1(mc6)
> + *	mc7  |
> + *	mc8  |- GPU card[3] => node 0(mc7), node 1(mc8)
> + *
> + * sysfs entries will be populated as below:
> + *
> + *	CPU			# CPU node
> + *	├── mc 0
> + *
> + *	GPU Nodes are enumerated sequentially after CPU nodes are populated
> + *	GPU card 1		# Each Aldebaran GPU has 2 nodes/mcs
> + *	├── mc 1		# GPU node 0 == mc1, Each MC node has 4 UMCs/CSROWs
> + *	│   ├── csrow 0		# UMC 0
> + *	│   │   ├── channel 0	# Each UMC has 8 channels
> + *	│   │   ├── channel 1   # size of each channel is 2 GB, so each UMC has 16 GB
> + *	│   │   ├── channel 2
> + *	│   │   ├── channel 3
> + *	│   │   ├── channel 4
> + *	│   │   ├── channel 5
> + *	│   │   ├── channel 6
> + *	│   │   ├── channel 7
> + *	│   ├── csrow 1		# UMC 1
> + *	│   │   ├── channel 0
> + *	│   │   ├── ..
> + *	│   │   ├── channel 7
> + *	│   ├── ..		..
> + *	│   ├── csrow 3		# UMC 3
> + *	│   │   ├── channel 0
> + *	│   │   ├── ..
> + *	│   │   ├── channel 7
> + *	│   ├── rank 0
> + *	│   ├── ..		..
> + *	│   ├── rank 31		# total 32 ranks/dimms from 4 UMCs
> + *	├
> + *	├── mc 2		# GPU node 1 == mc2
> + *	│   ├── ..		# each GPU has total 64 GB
> + *
> + *	GPU card 2
> + *	├── mc 3
> + *	│   ├── ..
> + *	├── mc 4
> + *	│   ├── ..
> + *
> + *	GPU card 3
> + *	├── mc 5
> + *	│   ├── ..
> + *	├── mc 6
> + *	│   ├── ..
> + *
> + *	GPU card 4
> + *	├── mc 7
> + *	│   ├── ..
> + *	├── mc 8
> + *	│   ├── ..
> + *
> + *
> + * Heterogeneous hardware details for above context as below:
> + * - The CPU UMC (Unified Memory Controller) is mostly the same as the GPU UMC.
> + *   They have chip selects (csrows) and channels. However, the layouts are different
> + *   for performance, physical layout, or other reasons.
> + * - CPU UMCs use 1 channel. So we say UMC = EDAC Channel. This follows the
> + *   marketing speak, example. CPU has X memory channels, etc.
> + * - CPU UMCs use up to 4 chip selects. So we say UMC chip select = EDAC CSROW.
> + * - GPU UMCs use 1 chip select. So we say UMC = EDAC CSROW.
> + * - GPU UMCs use 8 channels. So we say UMC Channel = EDAC Channel.
> + */
> --

This makes sense to me. I'm interested to see if there's any feedback from
others though.

Please fix up the commit message. Otherwise, I think this looks good.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen 
