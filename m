Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3064F53F7
	for <lists+linux-edac@lfdr.de>; Wed,  6 Apr 2022 06:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbiDFEHN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Apr 2022 00:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573043AbiDERsH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 5 Apr 2022 13:48:07 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C94D1110;
        Tue,  5 Apr 2022 10:46:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtZRl8iVobZMicMtSM+FjcBsCK8kFJPzPaPragrhKwPDhm7VbhoDtjbl7Ioj7Dcb41OR0iBZXJi1KUAbWRoc3nsGozvQG0TMbuZnuzYbv0q3NXMfbpwhL3j4kYTSMSZdporFGZwnwIvO29DeDfO2jAmqVX4clKrwkzvj53HujolGizqLSSufZ1asUxJaPQF77PTRCGKubCNogmTbWxIuiCnxcD+uHZayD8aKRtBtp+LjDqm0AXegyK+W0ON/91aXUtGNPm3InEpOtBd9OgC9PvnM88+jseLpTDQLskIGLNfhRwSbG1X2d8EuzGt6d6+ysFS6NIpZ3VNJmxLhHABBMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JV5+lWivMPFDqC4arQv+GIJdLRycJwGHCA3ijOG52WE=;
 b=n35ILqQ021Xvq7yW/OCvplSUn+UOF9Zk2YQK81HEajj1186QpnCgvQZ4hxSF3ErTnr8g2rg/iIDPO5f7EzErRyDiuf8UZ1bqvNBmfOmtltvkCO47SsDQBkd5DSkYCmS9etrX6pvw3oWzMMmOPaVfHXWjiUX7YkfEPk8GAfn2QwCZgub1RJ4EjaMxM6pK1qHA1ULUMqhdRh8HavJ0thGHx/hmaFspamL33IVtlRDJ92xSZGYLjOceprCdNR3/s18pHAZzya27OxJkA5K2P6ByN3Mpy2puFm/HMXVH0dJ2bLCV6qGmYzSO2hukrqvVccqdk429rviGl4ZDtgA2cqbAbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JV5+lWivMPFDqC4arQv+GIJdLRycJwGHCA3ijOG52WE=;
 b=oeR6p8jmmbXgyqSAXDZavF3vUXfnwcgPkOcJkhQhxaPyCc+hhtBhKicLmSXAU2Wu1MRozUUNIXJwX9WR1Gvv7m50O9F0bcZZyZ7aZ0xM4A/PhLY47vSB0aIX+PJUZAVtRw/R36grUT0qQ3u5zH+KqJ3v68Dn7JiUcMSzUMM4/cg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 17:46:06 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::981c:a9e4:48c:e82f]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::981c:a9e4:48c:e82f%8]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 17:46:06 +0000
Message-ID: <495705cc-be0e-9eba-48d4-231f851354b0@amd.com>
Date:   Tue, 5 Apr 2022 12:46:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] x86/mce: Extend AMD severity grading function with
 new types of errors
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bilbao@vt.edu
References: <20220331163849.6850-1-carlos.bilbao@amd.com>
 <20220331163849.6850-2-carlos.bilbao@amd.com> <Ykx59WvoWKi2y23x@yaz-ubuntu>
 <ec7dc7e7-5808-58f8-cbe9-d8fdd2de4c35@amd.com> <Ykx/RYZpKi5SQ/NN@yaz-ubuntu>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <Ykx/RYZpKi5SQ/NN@yaz-ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::25) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4e4ac35-5344-4b2a-c5c4-08da172c2947
X-MS-TrafficTypeDiagnostic: MN2PR12MB4486:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB448661F06CA4FEB50045F546F8E49@MN2PR12MB4486.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ISFM7SJ8vBtLlJWKOe8SkwwLQdjAPCjjAbY4IZqd26T+kXXyk3h5ob6q99x/b+6Fc35CdT2ZlxrhwYlu1cJZr+JeSpe11WlPBTRe4+Dd+KX2PK2nS7ZAuFbw63+QfXHJ7iaf81dRqGB78KnUtnjVI9qBuQ55Y8QPVgL8sWGglCjRg9KPXO0KXLNBzEihtY/v9k0Tni6VVQHv0bC/Bu22FxJmxwezn8fmvbg9EFv64H8RGURVTnlflshLz7L4JcG6NtpT+6zk2etZW+33WkxqSNgryzOlrouabWlG/kOitLCnS2fqoCAXG5150P9wsAGAy9TI9VNuRh5wJZHFcZLnNF0tFdzYwkqes9D2bsq1IjDhgdq4rlHKHpaNzCBK3ungciC3vChNDXHNBTZhGMc5WQ84tq6XjnwzVDyv2buWNn/3jOQvpGiUhgc8Ra7j12LPd6HIZ0xPOIXM+aWsq9bX1jV8zzmcJFY7PIKY7ZJZhIjSEYZLGcMc0XsdJaXxIe74Pey/+f7cc+iZqjauskqiDFY/K1SghLRTDqhgPOa2eGyB0lwFFg1f9SmGPwn8MJs8jNKgoTwrrmjl3aOBQQLjrKnQLBpIRcn1eWF8IRFBQ+VsZpA0+YPWHHdmF9tuQTzCYkIpTDFbkt9T5MGFiRpN98EbhG4qx6Tm3jcFSl16aTHL895lFGpNtNvY2pyTfzGklRW+9BLWSOyPduxuKgg4ENN8rSwpmQ9DPdpUcSD7E97cP0pFWHDxgCtXsHSY8rfS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(6506007)(6512007)(2906002)(6636002)(36756003)(37006003)(316002)(44832011)(508600001)(38100700002)(31686004)(8936002)(66946007)(2616005)(26005)(186003)(5660300002)(6486002)(4326008)(31696002)(83380400001)(86362001)(66556008)(8676002)(6862004)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2xtd1RXallxdzZlZUVYL2RmZlQrd2dBNU8vVXdEZ1QzT2U1VFQrc2htRmlK?=
 =?utf-8?B?OWdIY3hWWmR0WU9NcUpVQ28zWDZLcFVRMitVR09GaDVseG4zd3RYZkM3WWhy?=
 =?utf-8?B?WkR5QnFweWU2ZFIzZHNIbklIbHdsWjB6cENFSHI4cmRNRGlzRDM4Zjc0VlRC?=
 =?utf-8?B?RlJRUFo1Vk5ZTFlRVUEwVWdqNEVCNS9HOXc4UGt4TWk4cm9HTnFIUHM4SWVv?=
 =?utf-8?B?SGF6SWp0aEpZT1h0NUpLRng5bk1RazNxQmp3eDVYU1FOMVlHQTZJaGZFVjlr?=
 =?utf-8?B?UVpSOHIxdllQUUhBNUNkL295L3pTNXg1U2dpbkcyTytiQXpQVEJCR2QrUlVy?=
 =?utf-8?B?MUV1bGErdGlGZzFwdHhNM3JGSXJraEFJQTlaZUYvR0ZOQzVOSUZZeVB4L2xY?=
 =?utf-8?B?ZUs1dE9tQTZMZnVKdkY3NHAxUkRObnpXWDQwTDlaU1BGL3FIaFNMVTBFSjlB?=
 =?utf-8?B?elNnWlR0RWVueHg5NUZrWWJuREN3a1hhMjhUaC9yNVduNVRibDJiRk5CWFAv?=
 =?utf-8?B?dzB3cGtKenA1WW4zYU4vYmdVSzlSZnlhSFBKN00zS1IrckhUVTFZaDlDeGl5?=
 =?utf-8?B?ekhkNkVDSWwrTmdiNWFiWGN1SUpiVXJucmc3Vnh1OWlKTHdHd3l3S01NcWdJ?=
 =?utf-8?B?MDBCZVAxTEhPelJCQlRobnV2MDQzVCtVcCtNcVhVQTZ0RG13SWlseE5tdGRh?=
 =?utf-8?B?V3JwV1pYeEY1Vnh1LzNKeFdrdFpWMTYrMTRlcTh5RHZJeXhDTTUxT3FxMjh5?=
 =?utf-8?B?VHJwcjdrS1J3dWp2aWlXdVFEbiszc09IN2RaVTZoVldIZDk2aGgvVWNiR1lw?=
 =?utf-8?B?WkZTTktOc3FzWjNTMk8wUEUwenZTbGhKVng2cDVsbW5aSDhYZC9mSWgzenBv?=
 =?utf-8?B?SUhvQVNrZ1N3TmlBN0tvNmh2YTlQV3IvdjBEWktwY2RxRmplUTVleEJiQ2F2?=
 =?utf-8?B?eUVDcXN2UmFFbnhiSDN4VzRsbkZ5YjU5WHlxemZ1c281d1JhZHVON0ZPN25S?=
 =?utf-8?B?dHZLSkJTNTh6amc2WEltejcxRXpjMEgrS0Evc2txV090aGpiNTJBN1lNYzV3?=
 =?utf-8?B?SWl6UFZDRWo0c3JHSEZDUVdzZG15eVRGYnFNTVhhQkdRZ3JPUG91enRCNDN4?=
 =?utf-8?B?c1lTUkE4VElva2pJMlJWOTU5NmJzZWdZandNZ3N4dFd2dG5mcmc1dldiazh5?=
 =?utf-8?B?TTlWZGZCR3l6Z2xsenRpaC9OMGoyd0s1OEEzdUhGYUcycTFUMWd5eTdvL1dh?=
 =?utf-8?B?TnJZNG53enJxTDZOK0pYWldibFBjVmFlWlgyWGEyVGZ5YnhtUVpzeXkrbGE0?=
 =?utf-8?B?ck8xelhuNEIrOUI0N09uenkzWDZSSEJiL09LR0JTMXg3TkZpd3hIUXY4cHBJ?=
 =?utf-8?B?SFpXWlFQSzluU1FoeHY4TnZOM3Q1ZDdXY2RQdktsZWpLMUlPMTJTbDBUajZB?=
 =?utf-8?B?d0hrOS8yVm12ZjVmMGtxRjNDUkN1WnVsZVZ3M2JjSDROT05ZeTRhOVIzSTRW?=
 =?utf-8?B?K1U3ZEY3bm5vUUNpYlZtZG9zV2kyaHhkM2xURVJNZHV6S2FKWkExYlNYdzlV?=
 =?utf-8?B?UzZZUWxUOVpqbm83VmQ5MGhQM2pQVndYQVVUNDRvenVNcmd5MWkybENTNzM4?=
 =?utf-8?B?NVhIYmw5bFBSMVZFYm9zYlJzYVdLS0JVYVp1SkI0SjZsT1dEM0NHeHNZanl2?=
 =?utf-8?B?VThKclMxdnhJRWVFYmtEV3hqQUIyWks3Tmh4Qm13QU5SNHNucDFYUVBwMktp?=
 =?utf-8?B?MXNReG1UdEZFc2VUNW51cFJveGp6UVlpUmErckRHZlRXeXdPd0d0a0x1WXdz?=
 =?utf-8?B?MUdYZjdaZVFVemlCWVNML3NyV1JwOUN0dDZDamZPS2FFWU8xbEdqTUZwekd5?=
 =?utf-8?B?UzZpeVpKMEdmTVlWaWhBTmhjTys3OGJ5Z3hHQWZTSGJMSXRPNUFTeTA3amRl?=
 =?utf-8?B?dGlqZkdRdERORm9QTytSRDZveXdxTGtkRStFMmVENnl1VmxENFdEYkRMMTh2?=
 =?utf-8?B?VkNOcG5pTHBIeFFpcVBheUZwRHY2UVF3MWFsVFNLTG1UK1JkWWE3RFJOdjEy?=
 =?utf-8?B?TktVMU9Ic2w2VzRyY2lCZExTOFNYNDFDZnVlakdZa0xQUzg1OXpKU1pBUG1W?=
 =?utf-8?B?Tm1mL3JML0ppa2lnak1xVkZFMlZHWDlJNy9uK282U1hST2JXQ1pwNTF6Slhu?=
 =?utf-8?B?WWlFYjJTVzhDOUxtNG5jUk1NaGFMc2RNUXJDT0ZTU0JSM3ZUdTkrY3NaRUxy?=
 =?utf-8?B?RjBlVnhaVmkvOTJwU29SODZzejg4QWYzTmYxTmNnSUJuTzlqNHBXTnd2VEVT?=
 =?utf-8?B?UDgvU09maExGZFVyMjhRdGkyVkpLd3RIRzEwMjc4dzRsMUxCQ3Q3QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e4ac35-5344-4b2a-c5c4-08da172c2947
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 17:46:06.6622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QIRfoIBNXQMXDixNgxKJwSLM+30Icx2ulmokqoeH8gUmTkxClbph1vmjGA0AmSKpoJgoizuSJea39bO1AHhvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 4/5/2022 12:41 PM, Yazen Ghannam wrote:
> On Tue, Apr 05, 2022 at 12:24:31PM -0500, Carlos Bilbao wrote:
>> On 4/5/2022 12:18 PM, Yazen Ghannam wrote:
>>> On Thu, Mar 31, 2022 at 11:38:49AM -0500, Carlos Bilbao wrote:
>>>> The MCE handler needs to understand the severity of the machine errors to
>>>> act accordingly. In the case of AMD, very few errors are covered in the
>>>> grading logic.
>>>>
>>>> Extend the MCEs severity grading of AMD to cover new types of machine
>>>> errors.
>>>>
>>>
>>> This patch does not add new types of machine errors. Please update the commit
>>> message (and cover letter) to be consistent with changes made between patch
>>> revisions.
>>>  
>>
>> I'm thinking "cover error cases not previously considered".
>>
> 
> Please elaborate. It seems that all the cases in this patch are already
> covered in the existing code. This patch seems to simplify the existing code.
> 

You are right, will update. Since we don't "extend" the severity grading anymore,
i.e. will change commit message, it's probably best if I send a completely new patch set 
instead of considering the next iteration v3.

> Thanks,
> Yazen 

Thanks,
Carlos
