Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496554E98FD
	for <lists+linux-edac@lfdr.de>; Mon, 28 Mar 2022 16:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240950AbiC1OKx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Mar 2022 10:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239195AbiC1OKw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Mar 2022 10:10:52 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8192E6A3;
        Mon, 28 Mar 2022 07:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Md1F7TWnaE8mDtDvbwDVq+XRo/qeY0c9JnKwzYqNgXMKqC1L1P1CTQERVZb8szOJt1qz0rR55qSawWcUDf1jMH8x8SRih6A8r5PZIL75oGoGJv9nv2zDAzZlVMLGQvwAZERmepgw31KvKUrTRlSoLxyHmmRgvEqeyelXRUJEJOFupHiYzKuTUZlQF/2w5QwiShT+rHxNb0HGZ9nP4Syu315z0xRDHPQ9+J9BvGyLEkZr4NIOtuLBpUFJkLjJw8VWEjqmgRV6k8c0JT8QMH+5BVub1YkskyUSbo5cHyl1CivGSaXnbMM0/BAo0qX2r4Y1jp5BnQoUWz/jMt4l4F5Vsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V44Ke9rHZjJeIc7aiN4mjJDFyB/SvYGkjw7cmEgwpAE=;
 b=PjFgS8B5fwdjBpNxjxt7Yv+5IjErPd+mpIV9dIbXSgkIlb0Y24i6lfxkzbV17XauFeWnSL0OSJHyZCAjUF0iUs7WRcFTOMJnxiD5SjjJXldn1Fmz+y9tryzhphK4B3CDHOL7OYczXhtEXV+9Ll+kgsG2PA0M0yHNemf14tSOkJwRxtNu/fBNJgH7dMYhJhGn6OxImZ2ItpmWgeZrzJSpkvA0teWkJw57RsISIe4ziAcTRWBY+xPylJljyCUZIVemZ/ot6tXC98OgIpwvAIqKterKs1kaaO96VlwAvqL2DCCdkDO3ossRB7/1uy4+QvFDQQvoGRZkd4xpnXsehgDalQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V44Ke9rHZjJeIc7aiN4mjJDFyB/SvYGkjw7cmEgwpAE=;
 b=K/s9gV4P6ceP71o+8a5BuMBElLuYuDUpFgXJd9m6yttSk0HrfTfAykwzFBcgV+xVazMLoSntBUMpcJjQ2Oa9Z44Fn/YhMVgMPFELW9g72S9HR1Oj2OKNspdViogpqaTY80zrT1h4vUk8UEzae4PJGeG/P25LgCUuRyd+ccnA0dM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MWHPR12MB1517.namprd12.prod.outlook.com (2603:10b6:301:10::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 14:09:06 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::981c:a9e4:48c:e82f]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::981c:a9e4:48c:e82f%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 14:09:06 +0000
Message-ID: <af1a189f-4eeb-8bc2-fe60-ff317a3963f6@amd.com>
Date:   Mon, 28 Mar 2022 09:09:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/2] x86/mce: Grade new machine errors for AMD MCEs and
 include messages for panic cases
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bilbao@vt.edu
References: <20220328134131.736572-1-carlos.bilbao@amd.com>
 <YkG+SFCYMoAXrqJ3@zn.tnic> <299368f0-a3f3-c252-ab98-7dd324dbd3c5@amd.com>
 <YkHAcIZDpZER9knA@zn.tnic>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <YkHAcIZDpZER9knA@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0143.namprd02.prod.outlook.com
 (2603:10b6:208:35::48) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a4e0faa-d40d-44e7-dd43-08da10c48555
X-MS-TrafficTypeDiagnostic: MWHPR12MB1517:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1517A80CD647E9F88E8FE288F81D9@MWHPR12MB1517.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jBwMKi/HhVx9U1ZaeF2dBLEdE+gz4GjfE8bBiFLl7CfkwmSmG7yjZA2k2R3KfuOeAoXtyyYpF+89vVd4ZstnN+6o11xP5mnIa0FtaThq4ATpU81vn9YGVxkqLuGTCc/SNcG2r/p1XPG4lZ7HGpsjt4YmMhT/Hf7YnWghrWJ7Dw2+/Ny/KICJdv213Ctwg3RdfntCBmVeK36JHKCd+c1waLIM2CHWbf8KOYYMdfArW/M/VS9fAI3SBXIFBfVaPPhQXIkYiX8ug+YdNEA6o4L0HRJTQujiOiKCNTemsWiMbnYsU0uTxYSYrCFw69drYXqlpNfLu9P4B3EzNucT8RxB1B3rtHliVNf/Kq5t1AlqOzfSeEfgtO3ipgw6iYAXGD4DUomYnOUz7ltQFqt3Ff5l3GB8RMqbFBM0AxGuSLU5e7KoFgxStgm/NimYvnLuzl5KvDFc2FD+bZYdveTHl4NGbhUPoMZMekX6AVqhCVi8OPt38rSIVo/3G57TFMCWp5NdMQUMvRxxAZonHnrGQ4+4iWIHD+pRrW3nLnI6CVsWU+iaowbYkNI8h10zQgXfIuApZNxSIr3xkTdlNEFA0v4Gr7pprchBzoq5Z/ajJuT9GZha6YmjiQy5ezIPUsO704ik3ddEkRjWQVlK5wuiPDrg3QuW+QbuWLNlanEm+mkooI7535rqXZpA9P1LaDJ/kE1Mvc1wfoqkWMotWi6yp7OdM+RT5xVchwZ0diFgqbKEy0o4dHwEURnTvB7HhLctHTI6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(86362001)(38100700002)(4326008)(6486002)(66946007)(8676002)(6506007)(66476007)(6512007)(53546011)(44832011)(5660300002)(8936002)(66556008)(36756003)(6916009)(508600001)(316002)(2906002)(26005)(2616005)(186003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDd3bllCSFdJMWtHYXozMTY4ZFFEWm81NDhhV0JQcnlqK09VZXVod3ZQM3BJ?=
 =?utf-8?B?UHMxakk2UGpwc1NsTk54WmM5alRWSVhIV2ZhbUt1clpvVE5WMVBHS1AvSGF4?=
 =?utf-8?B?Zy9qdWpmK3d0SlRTeHFHaTR0VDV1VU5ueVdzOEJMMTV3dGF1N2huMk1Pci9C?=
 =?utf-8?B?VWJJN0N1T2xBQldBb2dUNnM0VmxseVhrREVZWFV1elVwN1ZTQjI5dW1UbmtP?=
 =?utf-8?B?M0VnUGVuNmFsNmt0Z0l2cTRiSytYSXFyVmhkQW9YTnd2L04wa2RZWXZicFZG?=
 =?utf-8?B?TnB1MlROWm4vOXZwVkEweXB1c3UyMjFxdWkrSUFVRzZkU0dudXBmdUsrcXF0?=
 =?utf-8?B?bDM3RWI3MEc0bk1JbXpmdndYZk9La09JeWlsOTA2M2xNU0E3Mm9hUjl5L0tL?=
 =?utf-8?B?M0RnR2pUeXNJWXdQa3FydkNLd0hML3psMGpjNENoaE8xMFM4Kys1WTJaSWEy?=
 =?utf-8?B?S0JJRS9kbkc5YnN1ZkdDVWdTUGdRajZmbXBRaFdMZXV3Q0lZbW9nNmo1OWg4?=
 =?utf-8?B?dzRaVGRXenR3YlpFaCtMVzF5aHZCeVNHTlR6ZnhoMWlXMVgrZndSTW0zbHd5?=
 =?utf-8?B?MUVxQ05YRTdtVzFPOGFGMjFrZWZaSWZKT1BNNDhhcys3ZE1YdjJYTXI0dGZ0?=
 =?utf-8?B?eUQ0STlRNTdRVC9MVU9kSzRvd2pxMzN0b3hMRkg3THlGSWlRbWd2aXJUV1dT?=
 =?utf-8?B?NXo0Ri9CTTEyeW5jQUFaZTY4WWZDaFU3RUJjdXBkODV0eVYrQVZwaG9MRjB2?=
 =?utf-8?B?UnhFUllRS1pVUnlUNjRHRC83b21qQkZQdHA0b1FmclFra24yblhka3JJdEFj?=
 =?utf-8?B?ZDFINW5FKzZPd0t4MDhZMzNIcWxBRVhtdWlPOU5XWTNHQ1R3VGVFeUszdlVM?=
 =?utf-8?B?VWc0aTBqQVNLTkg3RmR5amlFVXRHR3hmc3oreFFyV1JZb3FrU3hZZnVGQTBR?=
 =?utf-8?B?UGtqY1ViR2JhR3JzMHlwaW42eGNaQS9vKy9HSEpnR1Z6S0c5bUlXc3VJcVhV?=
 =?utf-8?B?S1o1QUc4QTZEM0tEbjVybXU3R29lTzV5OEZCSUIyOFJoeUp4RDBYRW8yZkNW?=
 =?utf-8?B?eWxVc1NaU0FwTlVTaVZHNmF5S05QRndjTzhmdTFYYi9pNWN5dklCM0VoOUNM?=
 =?utf-8?B?M3dGNFhyZEd6bXdnQzVPYlRkbG9IaXlLaG9RTW9SYlVRa2ZqY0tURXJIZzhw?=
 =?utf-8?B?ZXc5dDh1cVhPeHFaL3FQRDZkZGhacFZGL0FYUXVEbHZUTFhwR2hUSlFiT1FW?=
 =?utf-8?B?bEJhUUV5aHpCczRMb3V5TExlZVM0QnBvM0JJMnB0eDkyendudjFMd0pBTmQy?=
 =?utf-8?B?eFl2UGh6elgyYk0vSnBXZWxxWmkyWDNCdE5EbzhiWFQ5dms3Wit5bHdTVUtq?=
 =?utf-8?B?ZTg5VjZyenBWZVhHOHBjWk5pL1RrQS9pejlUcnpVQW13cFdsTTA0ekc2THZv?=
 =?utf-8?B?R3Q3eTA1VlZxTjEzNGZ0Rnk2MTNBdEFpUU1DYkZrKzQxK2k2U3pKUTJKN25l?=
 =?utf-8?B?bEZPSnNDcW50Z3QxVjg3cFVuMHUxQWc3NDUwUVM2Ti9ZY01YRFpUeWlaUzIx?=
 =?utf-8?B?b2dqMEh4OThPS2NMZHF2cndWWklkVVZkZDVuMEh6MFNYSGlBRnBQcDNjckN5?=
 =?utf-8?B?V0xwRTRLemlrUW5DQWRSSGlrY0s4cTQyWnJ0Zk95ZUFkYWFBZ1ZVbXlsK1JZ?=
 =?utf-8?B?dCtxVWZTT2lIRmJtd2xzdDRjdHc1VkVwT3JDL25PVTlvTG1nQUJPVS9JdXFV?=
 =?utf-8?B?Y1VyQVRocUpJQStLRTJaQ3F5WVgvcDN6Rmk5ZG1JV0FzclZ0OHhMM1lnT1lq?=
 =?utf-8?B?SkpkVk91am1odTZTMFBhdmI5aTVvcnhmaVlWdUpOQkVFZkxKdXJETkFjZUdP?=
 =?utf-8?B?Zm15MU4ycDhIcUgxckFtOC9UZExmbGNqa3VVdWdMa3VmQXJrQis1VmRUK05X?=
 =?utf-8?B?OHZtVEhxQ3BULy9VNHRRZTBIcE1IMlk2bSsrVlFQbTFxbVEydVVXYVdjYm91?=
 =?utf-8?B?K0EvL0dmeStxM2cya09BUVhrTGgwRXI1UFJRVWgzSTN0Y2U1dk8rbkdjZXBP?=
 =?utf-8?B?QnhvUUwwYzUyYWtDeGdkNXQ0NWZJcWw3Ykt5TGEzbnR6NjAyWVdrVzZIRThy?=
 =?utf-8?B?SUt0bkttUkFrM1UvWEpaZTBvUWxMa2huSXRMRlRMU2tqdmV2WUpHOGJUVi8w?=
 =?utf-8?B?ZnZqbnZLL1J2UE1NN1RNbTNOdlZ3UkcyUGNXZEh5RnFSZkU1U2pzMTB2VEhz?=
 =?utf-8?B?UXRKSXlwRWxzYUxvV0R5RlNBaktBbWpraEJmQWlUekFSZWZrN09Hb3NGZEl3?=
 =?utf-8?B?WjM1bXkwL3g5RG5HTmNnM0pBRXp5Q1FxUGl5R1Z1V1FSSHVxR1Zhdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4e0faa-d40d-44e7-dd43-08da10c48555
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 14:09:06.4071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qO+Hcg1/APw1RfgnmHs62fOvFxzi07QE9qzEjBELp+5Dflwzb84biVWo4Gjx1b8/l85fcbdG7d8HqUpyztVXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 3/28/2022 9:04 AM, Borislav Petkov wrote:
> On Mon, Mar 28, 2022 at 08:57:04AM -0500, Carlos Bilbao wrote:
>> Just fixed a typo in the first patch -I should have included a change log.
> 
> Well, we have the merge window open currently:
> 
> Merge window
> ^^^^^^^^^^^^
> 
> Please do not expect large patch series to be handled during the merge
> window or even during the week before.  Such patches should be submitted in
> mergeable state *at* *least* a week before the merge window opens.
> Exceptions are made for bug fixes and *sometimes* for small standalone
> drivers for new hardware or minimally invasive patches for hardware
> enablement.
> 
> During the merge window, the maintainers instead focus on following the
> upstream changes, fixing merge window fallout, collecting bug fixes, and
> allowing themselves a breath. Please respect that.
> 
> The release candidate -rc1 is the starting point for new patches to be
> applied which are targeted for the next merge window.
> 
> ---
> 
> and since you're new to this, I'd suggest you take the
> time to read Documentation/process/ and especially
> Documentation/process/submitting-patches.rst while waiting.
> 
> Thx.
> 

Thanks Borislav -would you like me to resend this once -rc1 opens?

Best,
Carlos
