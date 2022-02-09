Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E010B4B0154
	for <lists+linux-edac@lfdr.de>; Thu, 10 Feb 2022 00:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiBIXcL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Feb 2022 18:32:11 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiBIXcG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Feb 2022 18:32:06 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF16E06FB10;
        Wed,  9 Feb 2022 15:32:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKHaALuC0wxErlmCaBkZlLHjairYuiHitIT06omaIJ/vYm1YFnvY2/lHmzhsyfgTw84oQW6cheV3+Z9kPsLfF2rW+MQlHFgqQpgqGHhOkzIL67ONqfIkcVqHorEm+vvIsdk5FpPwSdwI7HP7scDZLOUH3O8CiMsPBiRTA6geeygG/Mh05r4zia/EquOd3PpAKS4w30GNSKdwmi2Q8JzLg2F38KnERc3QoPsS8iwo610ppRNEzcHnl2iOXN9ip1AMQbgljm4ve8fdzEfgZne7fpAIkuG790gHAKURji/1f/0eQ1GwdWxoQBDfU8kIcgV7j1zDmoIqL5MvaHwqor1j3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fg0eDReTXKzHhnsZk5b26D/bF8aYzf5Crdfweurxw40=;
 b=B8vEGpYm2IWCSfKmaR6Oql56hMY17zDTFW6wxMjSe4WwYNOPi9esbfS+3045EJ4NPTeLgWVEGcTNeFixBoL2fhaMBUiUMbhAQ5nB0vsz3srHE+a/QTN4dJ3xwyWmNuVDu4qSm41q+d10WebMzGT7n1eH4UbFdasfqdmtR7Ka/wfHHKufQ/Na7OZbt4ZSnp3agxKXTQ4P10DkvWUAsGyPlv02iH2UeXQDnUviiHaHodxOyrHmVchYwAJ7csX6GIdKZZN2DtXtPG7brLPODrtpjN/tDmu9kvOfdmqxC3Lj+jKUT6gMrt8JJtVXV0vHNtZNqkZXubqDGfFYDYetOohj0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fg0eDReTXKzHhnsZk5b26D/bF8aYzf5Crdfweurxw40=;
 b=KT3ZMNgZKj7s+eSpxiMYAm/sdoUN53qkXoAQGKUXR/Ze4e7Ztc0XNJhkvoGgU8vKG+sMRn6C2qg3ukqRNa0xaWyUaiI7pM7MQc2B71Vx4CakgYFkKReGtVakyzVJ4VOqvg2RRo5yHHy+fQHa4l0AMx52lc+F/ADdUjJ0833lFto=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Wed, 9 Feb 2022 23:32:02 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a%6]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 23:32:02 +0000
Date:   Wed, 9 Feb 2022 23:31:57 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v7 03/12] EDAC/mce_amd: Extract node id from MCA_IPID
Message-ID: <YgRO7afWufCF/fxi@yaz-ubuntu>
References: <20220203174942.31630-1-nchatrad@amd.com>
 <20220203174942.31630-4-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203174942.31630-4-nchatrad@amd.com>
X-ClientProxiedBy: MN2PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:208:e8::16) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d18b5e51-e199-449d-91c8-08d9ec24603b
X-MS-TrafficTypeDiagnostic: DS7PR12MB5887:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5887C923EEB9ED631C235ED1F82E9@DS7PR12MB5887.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zJXVm7hQ1Xug3T2zRQumtPdHI5d0WuxGXQcmfW7Dt9+r6BEgaoTB6LmQAaqpKyJqkn6xrOd4HsHpuAnz47YYHziP1rir0PfMILNzVLLxGRt0+/EoZkPu0CngGSoBpgeeg9NZJ/3DoReIzFlMA/Svxh2U1J8DFYesQFnjGVmoC8pbHl/X6L/7QxF8ZNsYrPOgyDSj5ILwBfWa3ogVMB79XEbIeGtUhrczFsnxudlIJyotfFwosmNcg0JSYgE+Vn0bjbT272G/AsatULrLLkNOVLVI188CtmfFE/noWp53ExogV7Os1q8tCjano9AQGBVLN5PS9xxniE6ud4kLGFG4rt9wI89ZQ/THP+oX5aH9KEvI2nXXskMINUKm1AC8XPmZjzS9A5Ep1Zfmu+eVsw3WYJyxpHi9Jj8ymWzVAwcvH5utfr+X7Q6Ob51847CVOW/wYcNaP4HdDcoU6YOt14CuIVThpJIzaRYgdtbJ3AmLS0/TVo/n9I3fBeXgGGmAFCv81/EgzEEMEPrugXaIWnNKBPXLNqy+NEsu2/KjP6kSDzNOsyHwS1muulHs4ZyjddrDzhAE109zhEi0lAU2z7aUSSP7OvD3jgDPXBExvKWGl04adl0D7DZrrALe/4Bdwx0/7SymLV4Hhg3eybPqosIjqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(316002)(5660300002)(44832011)(6512007)(6636002)(6666004)(6506007)(9686003)(6486002)(2906002)(33716001)(6862004)(4326008)(186003)(508600001)(38100700002)(4744005)(26005)(8936002)(66476007)(83380400001)(86362001)(66946007)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W0KFDbxfPzwg1xPlZunuVVzugxctJPfLYr/SO4Uubyh+Qy/dmrB9EyFJE95U?=
 =?us-ascii?Q?IzKYaxaTmyrI7tO5PEAfRYrrC1ho5VPcE3t3KFEtM1GF26SzjwECE6QNVviM?=
 =?us-ascii?Q?3QX373JIJPpXqiczgaTPXDdlA/dKFvnXrEa+UiHb777+RZ5y3Y2q7hpqEt69?=
 =?us-ascii?Q?/pxOVCXns3FhyKkuXMD7pppnv00gJFXnayUHuDfCRvo46cfWFCm+jzPmVoWQ?=
 =?us-ascii?Q?iYtW27knz6bw0aWGWtWrE34k690K7j+cYBhGzaHSXSgs5nFt90tmh4KhEcqS?=
 =?us-ascii?Q?mghwDrayjBLjbLGbN33DaaVb525W56le9IgCPkBj6MSy/hW5BBiFEox6jmLD?=
 =?us-ascii?Q?liKNNCEvUw6iH7JpL/+Eogd8v6fpGNP2ckOQl14rwAARFGaDnqBoo5QEC9IP?=
 =?us-ascii?Q?CLqwuZ8FvX1e5WatrLA7ptD/25qqi0PDSj+ahENAC3x4HFFgA/+GsONBcL6V?=
 =?us-ascii?Q?zvKwsoLLgevq4ick2E/8NkEmvs7p11evC8JnBijiNq0Xuja32AKoVbKakHxW?=
 =?us-ascii?Q?jAEbp45ABtfpstbeV7dFCJRI8g71AW1OlZeul3XbwWQppu+pVR9tHFM7xRqc?=
 =?us-ascii?Q?ZshewvUfWRZjZtKF2rcC0ZeFQsY53EU5Quef/kcx/4xOYB83NYfGrJa3T+5Y?=
 =?us-ascii?Q?Iy9r+6hO8Blm0yczmOu/TxC1ym9ikpMJGdGw0d4SBADa6PL5GAQfuwrlXw4R?=
 =?us-ascii?Q?qo6Vk/E1IoF9oiCASwhE2rOE4br37oPjfEMV2As8XYBR14bVIG5V44tlCzNk?=
 =?us-ascii?Q?Tjff71FzKAZoL6JS9IL8go3tHkuADyCOhDajeQejAricluXPRhzaR4n272Op?=
 =?us-ascii?Q?mFKkQhhkjxSrZVd3We9rwfcz9PrMsc3zRS9Kh7DTK/i89P1eD6zdTFAaU7yy?=
 =?us-ascii?Q?3RQtSWx9aC9ABnPeSMQH7KUnun1TTslh13imE0gvcE0PEru65EPPh+kXhUJi?=
 =?us-ascii?Q?BSwuw6Kigbmw085JXsJq5oiFn3JFevu84jqGWy5/5EwOMilspM/p+0xjXEMn?=
 =?us-ascii?Q?Tr+vDJssvuNS5y3LaHMrNqnR+MDRadd47P4JeR2qfzUzxH967TEOQim/JfpS?=
 =?us-ascii?Q?WmhOj4L8Lia1QrkzyMqvuKjWyapzLzIvFeK5t/OQa36CZVi4y2HG+k5ckNKm?=
 =?us-ascii?Q?N6LXOj/KLZOqoyGv6fGqIflfsKLR+VzdwBpVLkJlfmElBAg7DFgzYk7WCte6?=
 =?us-ascii?Q?4hUk6zIE5BY9VBUMRA7+h1lNxDWT7wcggUQmyadSr+XxzA62lKecuW7Q+OWX?=
 =?us-ascii?Q?a5+5odTwBWUlzGXPh/21ClU3KKAM6/+rgCTfTWjH4aGjJqqSXEYCKJbQvRtm?=
 =?us-ascii?Q?kc641MkRb2PMxDUf5gaEhgwV2W+WsZny9Z/Xy9E6ikjcE6r6UIFCBi2Em4Zi?=
 =?us-ascii?Q?D+/agaitqoALB0yKXomCfHz/Z0G1AeahOsxQlMt0VnmZGxwTlIDFods8jjwI?=
 =?us-ascii?Q?nC37fWpJXQqwgGVXlx/QeDRan5WwfLp5adBgbszgy3f6cWtol3z7wnJx2fdu?=
 =?us-ascii?Q?9bSzesOfFTg4FfTmcJc6moCt2/Qine5t8rM1E6esfcJoUJX8DdPz3FdRzXVv?=
 =?us-ascii?Q?usSoQeh63SkEKyOyNWbPOj/j6H3rFceBaZjwSp8IQuStMk1N4TU8v853ljjC?=
 =?us-ascii?Q?hbx3fgxydjJ+7Dlz+pOPlzQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18b5e51-e199-449d-91c8-08d9ec24603b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 23:32:02.8380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NFPmOL4TO5A76pyv8ArutvqDMZ9MXmVMWYNVWQtXGjoZReyQApf6qv8ONTBh1jP2I3/eC8+I0lQuOM0NuwRyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Feb 03, 2022 at 11:49:33AM -0600, Naveen Krishna Chatradhi wrote:
> On SMCA banks of the GPU nodes, the node id information is
> available in register MCA_IPID[47:44](InstanceIdHi).
> 
> Convert the hardware node ID to a value used by Linux
> where GPU nodes are sequentially after the CPU nodes.
>

Terminology should be consistent. I see "node id" and "node ID" here.
 
...

> +		} else if (bank_type == SMCA_UMC_V2) {
> +			/*
> +			 * SMCA_UMC_V2 exists on GPU nodes, extract the node id
> +			 * from register MCA_IPID[47:44](InstanceIdHi).
> +			 * The InstanceIdHi field represents the instance ID of the GPU.
> +			 * Which needs to be mapped to a value used by Linux,
> +			 * where GPU nodes are simply numerically after the CPU nodes.
> +			 */
> +			node_id = amd_get_gpu_node_system_id(m->ipid);

As mentioned for the previous patch, why not define this function in EDAC?

Thanks,
Yazen
