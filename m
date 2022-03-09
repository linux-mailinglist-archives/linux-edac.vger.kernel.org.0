Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EE94D335B
	for <lists+linux-edac@lfdr.de>; Wed,  9 Mar 2022 17:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbiCIQHg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Mar 2022 11:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiCIQHN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Mar 2022 11:07:13 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBCF141FC2;
        Wed,  9 Mar 2022 08:03:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4XESlXPeXOjxfTF27DQNhWp+Y0hQJd2C+jSFpDWjp6Yrj2/mmTU6MRFLlZis/NQzFoJASca7CrzheuZdSPGdo+JudU5KDfI2hQLER7yUwjk6ECqDLGGEsJUQLO2NWeXM5jgVbg4ee1q15zZRPMtEyqH2bpxNNy8XARK5iWd5cwaN6NXQL8v4I9iTGmvE/Me2WUwMkN1Lu8lWOzdb+Rr9aHrz9y7U2e6YeL2unEZvBPETeS6WtcdJANNhsQzeCgevdTG+ks5UyqxU9LD3/OyhOY+XsmoBxuZTvzY2vcqUT06aYO49IRMIGPVjQSgmHRaWD4fHEVnBQJ8ggv/CGGxGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrzP2UchQi43pCnpSUo0Ny3bsCPmouvmqf/3EbosyZ0=;
 b=cv4b4ZPDEvjkByYsm8KKxF4Bod2pNRkUxDW8Qi40IhgZiOW9OB6Nug4bNyYevZzUfC7a7F942+IiIBtAP9ltUwQSo1PaS+7flrf4SNScN1inCbzE9fbmO0eicOD3FKdwnHIRMKgitcejZwanZO8EU5e6g26hWEtxvWQ9fF1i0/K+i2EoPyya2Exzb2sNPDzNsePlrx0HMOcL3iPExGB/y6Q690l7Xb9LXLHaJnOTE2U7VSuTv5cjJY67Lcv/U0IGABPaI7468bBQFwO5v6AUEDOwpP5QrkNO9Htf/OH+/ARXvrWZn6iQCJ7yuEkLRmT8yUk6U7QNdyclhsHc4oPVPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrzP2UchQi43pCnpSUo0Ny3bsCPmouvmqf/3EbosyZ0=;
 b=F4yzpfq+loHGNJhpMIukzSLrst1FLOqUmFutKjKJWHNFXAHNXXT+pmhSsBtyVcQ3w4iMCelMiM/P+JeaPz9gDmj8r6oxIRPvklr5P6neYP6ZQze/JdxfE/n36p0kNMbaWy/IjsHV+xg1/t8m2AsaxjxqshjRgIRn6euCfF4pBb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Wed, 9 Mar
 2022 16:03:20 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8d44:d69b:b031:1d50]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8d44:d69b:b031:1d50%5]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 16:03:20 +0000
Message-ID: <7967cc8f-11af-0236-9ed6-ea9a84702965@amd.com>
Date:   Wed, 9 Mar 2022 10:03:18 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] x86/mce: Unify vendors grading logic and provide AMD
 machine error checks
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bilbao@vt.edu
References: <20220308184133.712761-1-carlos.bilbao@amd.com>
 <YievKnn5hSK0AvMt@nazgul.tnic>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <YievKnn5hSK0AvMt@nazgul.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:23a::15) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cf39534-9a1c-4b52-01de-08da01e654cc
X-MS-TrafficTypeDiagnostic: BYAPR12MB3126:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3126608C4C7F0ED3529B03BDF80A9@BYAPR12MB3126.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6hO++RVHRefkxYcbKx3XT/2Usg6OVrvP7pMnOfvfD8/fo0B5gf5IhkU9qnNQ5BYyMU3BNAJttNA9BwJxvlgY1eV4qp6plmoRtMX7XocKl9Lu88jxYkzuftKxi4Fi6pIle5GN4Y87j/zbQlbPSmhqM6TOgdMQIDZorGqtg8WYzvxyz2TeYNCc8TLRMnEZDTEuW+s2YKMYqjRkPVWEwWDNa3t/bP+ctppVzjd46YxIkPZTBOoro94ES0wBjSLw1vRnDtp4y5oYxXEmZxc+NHyloXZTSOTGeze8wJrseN8AO4RCegR4FIuoUFOif2HPOP2o5k6FsMNCzhLVEjoqpcnZqyibpDhBUglhTGMdfG4oViz3qFDM0XKy5UF9gAZDpuvkiigFSR/2oLBgXp2/qa4/BFqAgWnBuZsnnBAANNKPtKB8gAob8kb13nS7Kg5A7bzrqxc6nlnAMBc6YBtZ8PZZEqosQRLRBqd2KqbwQHREJv8rYoJjzG1p6CRt21vHGV2aMc5aguFajJhlt1J06wFCloTqMX25reLImr8L7/eCuGFqKsRuZuNcWqP0uCABAI50GqPJ2EKDikHksD+/FHmApYOZFlBTwQwyOQT5cv6IgmjgPSUpS6Lk1ht9krZ+Nyv+pmNiVqUko9/NBPNMPJ55t3LkL7IIC3fbpx9DVgva8d4sLH1FtUIf2SdmGvhIZB+8nXuPbArLHbTQaHXJ5VX5OwzXYZK7j/35J0qxL9bpOPT+lU7X3GtR7FJQ4xez4Tw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(53546011)(8936002)(6486002)(6916009)(31686004)(36756003)(2906002)(508600001)(66476007)(66946007)(66556008)(31696002)(316002)(5660300002)(4326008)(8676002)(38100700002)(44832011)(83380400001)(26005)(186003)(2616005)(6512007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2JKQVR5MlpYK2R3QzFDVFdFZ2hZb0M1dmlRTzh4NkJCWnBKTEdhZVU5c1lC?=
 =?utf-8?B?RzVSc2FaaXQzM2thNng4cFBkK0VOSFl0T2Y4djlMSndZZXd2RmxLVU9rTUc3?=
 =?utf-8?B?Snc3dnQyaXNYM3lZT0RFYkNRNS9PSEhYVGN3ZzhBa29vaDVjOFNndjdUVTB1?=
 =?utf-8?B?Yjg2T0x6RzBTc2NFa2pTYmNOMisyK0tMOWw3RVdUcE1TdmZ2TENmbmlKQis2?=
 =?utf-8?B?UTd3QWJ6RmxLWjJ2bVNQeU11WHgxa1pEOUpFeWF1LzE3R1JTTlZxUWxEU24x?=
 =?utf-8?B?RS9OTFBIcHVqWlBoWW12eEkxeGp2TzF3blBJZTI1RDRzNjlKLzRPNmVNdjBl?=
 =?utf-8?B?eXpRSGVvUzc0UUx0R3dkSEc1NU9kalRmTEFOT3ZkTUZPSWpUdFowVlY4WmRZ?=
 =?utf-8?B?eXZvNEd4ajU1S1VTbi84REhlUkFON0JqR3dlMnRNRVJ4dzZPWERuZ2plMDhB?=
 =?utf-8?B?YkFUR1ZCMkRPSVM1OXNubjMvOUNrc0IwaFAyV1M0QzU0VzNBL0FIREVycmk4?=
 =?utf-8?B?SVBIbGFudm9IcENtNlVTQmo1eUhhQXlQMW5YR3JQQWZRTnhycXc1TEZwWmVY?=
 =?utf-8?B?cno4Y05nUHNsK3dieTFOYlNTU1ZpNnJrQzVqMUxVeGVvcEt4d2tsK1hMRDQ4?=
 =?utf-8?B?SGJrZzBIaWtkbUp1QVh2MDlRbWdPRjBFbG11cjBqRFFZNjdYUC9WTHFkRk11?=
 =?utf-8?B?N3ZLUHNSWFRXVk5UZDN5Z2F5dFBweThSRGZmWjBOWkM0Z3BGRTFRSm8rV3ps?=
 =?utf-8?B?MHZpYUt4aHJETEx3RG9GdWhRTytZQnYzSHNxelFBVWVudUROaUNuakR5dTFO?=
 =?utf-8?B?MGlJb1hFOGJ6ZCtXRVhXWmkrMndHODdwdEtnSW51S25Bb0lZbFE5VzVXOWpk?=
 =?utf-8?B?QkRNYzlwcjBhVnI1VmswM3JmdGJrMUR1ZUtSM3A2MlR0YjczUm1iYk1QS0dm?=
 =?utf-8?B?TmlDM3UrU1JjSCtTeXMzN0g0QktUWVVIQUV6dWVqZ3dGRWwwaXh0ODFUNmVH?=
 =?utf-8?B?TjZNQXZlb3Rrcy9EYVk1czZXZXJpQnQybkFXTmZKbWR3R29KT0FaOC85QUpF?=
 =?utf-8?B?aElVMTVWSGxZUGlISFBvZERRaVpLYi9wckhzSW1LVGNTVmhlQVpndmlqclBk?=
 =?utf-8?B?d29jcnVnZVFWd1lEbFhGV21LWjBvSU1BZG4xK2ZpOVBtU3g2WjE2T3BDYU9m?=
 =?utf-8?B?cEUreEp2T2FvYzE4QkhVYUZhWEZ5TGQxMXJnVCtQenpPbk1YMTBRWHVhL1BJ?=
 =?utf-8?B?alVZd3gvUWJzOVludmkvbDl4cDJzQ0JhckpYeGtNM1dYR3h4Y3JDQVBGTUNB?=
 =?utf-8?B?Y1FRY2pteTJPK3hJUTRWUzl0U0NVMHlvUjZIVlJtVkRKZitzblpjaTl4RWZj?=
 =?utf-8?B?ekJXUmRtSlI5UWJMNjRsTkdrRVNBQjVOeUlaMzA4dkorRERnWmI2b3IwbTRq?=
 =?utf-8?B?aWhHQkNCbXQveXNpRnJ2UysyZklScEVWbDd5bW9WWG0yTUk0dU1OakRuZHNC?=
 =?utf-8?B?elFjdTNlaFE1eEMzWEJha29icEhBQ3J3VmNqTzNWYkdHZ2JXdEozNTZ4USsw?=
 =?utf-8?B?MXpXaGc0aENIalhNSzYxejdiVlE3V0ZabFBTdmloL2x1dXZtcWwxK3FqTXlp?=
 =?utf-8?B?cXAxK1FQVTZtMm1LTTFpZXkrUjFNZ2dEY3dYeXZ6WmZYUlc3M0F3L2gzcTFI?=
 =?utf-8?B?SDZmM2JPNVhpRnZzZmRvVnRBdGFQb2JjSjE4dWNGYWZENUxtMm4rblc1R3pY?=
 =?utf-8?B?UFhJQkNqeVJ0VWJoZTZRZlBOY21Wd3Nhb3dJQ1pZZmppcE9UV1pEZjdtb1hX?=
 =?utf-8?B?S3llaFpsWXNlNHFEeS9DaEhwem1KRFdwY2U3OU1sV3I3cTliaVlhMGJDc2k5?=
 =?utf-8?B?VW9BMm13Q3lQd1JnZWgxc3lESlN6dUxuY2dHUzV0V3Y1ZzdUOGpORkc0Mmx6?=
 =?utf-8?B?KzRNR0ZTd3MvUGhKMWMzajVDc1NwMXJYZll2cXphVzN5RWphaEo5V1dBZXM5?=
 =?utf-8?B?WUlpU2dPWkQ4QWlHbDBNSGRtNGVKSTVHTVZoMER0Ujlnd0cvSUI2WFZkTkUy?=
 =?utf-8?B?a0w5bWlVekFaYTV6aGJyOEI5VUlZcEhzZFFLZVBGVUhnWDZEY2F2b1Ura0dR?=
 =?utf-8?B?QnZoR0FVS3NlRkxwRUY3cU1ON2tBR2tyOHdQM0xuWHpMZzBWNDhBdktaN0hZ?=
 =?utf-8?Q?KuK15eHni7ctfXfr/849ZYQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf39534-9a1c-4b52-01de-08da01e654cc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 16:03:20.5764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+5lKkU38iCRTkjq0yjCABz+I9KZ5jtaItD4dhY43rePxH6h5E+x0fCs6fzM2Wc5CqN9Tfb7bkNS0zCcEAAYiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 3/8/2022 1:32 PM, Borislav Petkov wrote:
> On Tue, Mar 08, 2022 at 12:41:34PM -0600, Carlos Bilbao wrote:
>> AMD's severity grading covers very few machine errors. In the graded cases
>> there are no user-readable messages, complicating debugging of critical
>> hardware errors. Furthermore, with the current implementation AMD MCEs have
>> no support for the severities-coverage file. Adding new severities for AMD
>> with the current logic would be too convoluted.
>>
>> Fix the above issues including AMD severities to the severity table, in
>> combination with Intel MCEs. Unify the severity grading logic of both
>> vendors. Label the vendor-specific cases (e.g. cases with different
>> registers) where checks cannot be implicit with the available features.
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>  arch/x86/include/asm/mce.h         |   7 ++
>>  arch/x86/kernel/cpu/mce/severity.c | 188 +++++++++++++++--------------
>>  2 files changed, 103 insertions(+), 92 deletions(-)
> 
> Sorry, maybe you're too new to this and you probably haven't read the
> old discussions we have had about the severity grading turd. In order to
> save you some time: adding more to that macro insanity is not going to
> happen.
> 
> The AMD severity grading functions are *actually* readable vs this
> abomination which I hate with passion.
> 
> If you want to add more logic, you should add to mce_severity_amd(),
> perhaps call other helper functions which grade based on a certain
> aspect of the error type, split the logic, use comments, etc, but
> *definitely* not this.
> 
> Thx.
> 

Understood, sending a new patch in that direction.

Thanks,
Carlos
