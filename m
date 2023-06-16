Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846DB73292C
	for <lists+linux-edac@lfdr.de>; Fri, 16 Jun 2023 09:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbjFPHrJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 16 Jun 2023 03:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245423AbjFPHrE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 16 Jun 2023 03:47:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE312965;
        Fri, 16 Jun 2023 00:46:57 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35G6Otwk019618;
        Fri, 16 Jun 2023 07:46:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aEpk0yaJDKw4vVRGZqDhgPR1eVVuctHmrwY1BfE9DzE=;
 b=LbPJRVwjAyHqfTbUix87CVcGzyjvUrQJNNRpPPJIuN6ZybJv2NQ4I5vOViYC25ceETFu
 /qP+PTumAp0wQIT9oK2Mp/jSmBEu02mnSFU0njPRxYBUVu34zxHIyLp9pMGmEysuuDRd
 Q7MIUzwc9BZtXIGhJB8Q5bwPCqlyPM3MnteKIJxi0y5K8izhRKaJLtbTqEPGuVF/tBVl
 ma+jhen3KUy0nVkX+8tJHGvYwgpPS/5SVz5bfatldGx6Q2aBE2/uutjJwbR3ofv1kykE
 QiNWoYS7w+t35NeNR8gBQ0p+V6MXwfzls6BSCbLcVkxaIFBwf3rCVNwzoqT91EyFhIEc hg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3busjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 07:46:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35G7Hfbn038982;
        Fri, 16 Jun 2023 07:46:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm7nv4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 07:46:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U406YxsV0ITjEfwKIWO5jfrKHnIrsER9lIQKVkI8kZP7XZc8WsJCuE4eIbFw0yXuzBR/zbnppwGp5BDvmaxhtLjv47F/0mQNZqk74spvNRGiRabvRqMrozD9U3n0GHdsgNFIAvsPWxoHzbEeZH7hz+9y2VhsDJxwazZJrJNGkICoTC60YhGKC4lV2RolfU/TDdS9dQQq6Vlp+6VPRcd8osek2anpIMKdsxKOMQOfsInMWmM9cblZlb9qCcCOa9lYeD1dCNU2WdPiCRpo5XUi2fQZLAI6IY/pgv151qeqn1M7vr5otEjvEoameShRLgEvg4UAtwTZ1HF4WhApUkXlGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEpk0yaJDKw4vVRGZqDhgPR1eVVuctHmrwY1BfE9DzE=;
 b=TVlILPXm1M6cxmxeQqU1Z0pjTaR3zdZs3+00TpGWuemMGPM9Mq+ut2hED1R5OafKtuYAhvZdqP3u3/4ilRIYEG6cRPrtjW+YvvhYoaVgwppL9MywbSus9077cGsZlGj2N5KMS6NWPeutZQ0uv54x7BzXui3myNO237HZV6V49U93DK1L/QogOjFMCiE5BkpXRiRcw1+lDI40YlSQUl+oWp1wG9nbrt+eH2w0flEmKLLjmHlyv72D8EnY7U3cPpbxFrpe9E0lylY5FGFlmDGq3cnG8fLyRnsaab4odZ9gP88IzJCA50FC5ORE3pAolcn1aXO40J5jwpB9jFNe3s9kdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEpk0yaJDKw4vVRGZqDhgPR1eVVuctHmrwY1BfE9DzE=;
 b=cQn6Ch/Ch9s8SJWXxKQflLRMtjisnYT9nCmbqWUvr9hoFHxcV0yMgO8RGqZ6Q4dfLg71csGbjsHa/lWECGAJ5YgCkUtmYBnQG/sQBxdD7ktcR3a0c6CpKqUhLrHv5dO/VfUcgDd0QLvj4BvxID2PR1YpfWC0gtW5vsCar9tGJH4=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by CH3PR10MB7648.namprd10.prod.outlook.com (2603:10b6:610:179::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Fri, 16 Jun
 2023 07:46:44 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::8d9a:11b3:7f45:beb6]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::8d9a:11b3:7f45:beb6%7]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 07:46:44 +0000
Message-ID: <212877af-40fb-8c17-fa9b-4d05120381fd@oracle.com>
Date:   Fri, 16 Jun 2023 09:46:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/3] x86/mce: Define amd_mce_usable_address()
Content-Language: en-US, fr
To:     Shuai Xue <xueshuai@linux.alibaba.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        muralidhara.mk@amd.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, john.allen@amd.com,
        baolin.wang@linux.alibaba.com
References: <20230613141142.36801-1-yazen.ghannam@amd.com>
 <20230613141142.36801-3-yazen.ghannam@amd.com>
 <31fdaacc-cc2b-5ea5-8a0e-e5ccfe674834@linux.alibaba.com>
 <1e9b1a0c-564d-6a3c-c253-1b1da1773ecc@amd.com>
 <31816165-e3fc-5bb2-71ad-6fe77ecd64a7@linux.alibaba.com>
 <1171078d-fec3-297e-05f3-dc2e58bf2886@amd.com>
 <5428166a-2a27-b400-f013-541309dcee5c@linux.alibaba.com>
From:   William Roche <william.roche@oracle.com>
In-Reply-To: <5428166a-2a27-b400-f013-541309dcee5c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0126.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36e::12) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|CH3PR10MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aaf4126-45ce-452b-2883-08db6e3dd489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uWR0APUZ59Khd27lPmBmUg0ym1Fryl3aDlBMAgWWHCoZ01UwGwUN10wP3FSjE1Nndw/BeCbIVFfJwrsoZ3U7gWzqm6KV7StSW5o7O7u+wN1HYUJE2hF5bIp/7NzUPBIB/YnY1TsI96tax38blV0Ye13Djld0E2NGj4OSy1ZS6JL7B5HT6LcoAfwG0ooCW2OcURnNq0hiRAEQxebdZ0kvlUPX20Ih9Q0DKwr4cZ+7qeQmeXW3PNhnYR1X3CQvEfNOOesLU1ZRhRRZeQIjgB31PL1DcDIa/ALor0D6EPOUqHHypCiTOUDooutuNghFoKhoUT1RLqOmG9qqqrw9meE4eBiIKY2QxSkyb2O6aBqxLRTrLlmPjV94uUYoQw/B6OG1WJilnkGJJS/73GOp2xddgTOkbmvBZRuZl8I5dU/JkwG0kTen7eUFkpMfWATdDeC+jDYCA1jZ1EpnuXzCPaa916KJ57dcPZjg0lNonXZxlZhRbCKmhd3Mcs6IpWl40wJQi3TjbP9qkyDy33qdlmqKmz1uCrKc3qJqoEo75sGBAUpaQx2G66di3SB8y5zyj03cyFFNWuMw2Y0KPR8ych0r96VidjWyebc/SDFgtlCZBiVFzHq8ehS3GIvVbKVxX03E05pZgxk4aINRwqhTRta5/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5481.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199021)(6486002)(6666004)(86362001)(2616005)(83380400001)(38100700002)(31696002)(36756003)(6506007)(26005)(53546011)(6512007)(186003)(4326008)(2906002)(110136005)(5660300002)(44832011)(8676002)(41300700001)(8936002)(316002)(31686004)(66556008)(66946007)(478600001)(66476007)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTNKMVlwK0JnRWxFQkxUUWlLeFB6K0EyYVdzQjE4SmZnV250R094dUIrcXdR?=
 =?utf-8?B?Njh6WVI0U1pMaTRXRlR5OW1YZUxaRUNZdUtlMW5VQVRYbFdGZ21TUW80RXEr?=
 =?utf-8?B?bFlmcHFrUFRub0p2bkZZMTBEcmJCYVhsalBKQVQzQ1lIRnFBQ1c5dGNEZEFJ?=
 =?utf-8?B?dHlVZkt1UlVQNUN5aEtOYWt5ZnFMSEdNU3d1ekFtRy9qVGJsYzhTUHBEbU4y?=
 =?utf-8?B?UFBBdE9iRVBEUHltclZIemdURUtwTk5TT1FzZHdjSVA3eHlWZmgxWnRHM29B?=
 =?utf-8?B?cnVDMHFzVThaS3FkNWtaQXRPRDFrczNJSnF1NXdzUmhSbkdlVFRzQ2ZETGJH?=
 =?utf-8?B?Q3pXQWNNaUhkaUJyUFdad3NwMEZoWlgrTlVoSHRCdnlDQUFaRnpPbk5MQldS?=
 =?utf-8?B?dVhrdyt5N3MvUXFESHYwQzBUT3U1aWRJaUhsL1VqTWI2UmpGMkMrZ1lqc2Zi?=
 =?utf-8?B?aUdOUG9ZUGVZNlJjTDZJU3d5VjM2VzhJMUFPVW1NU2VRTy9oNHlwZHdqQU5x?=
 =?utf-8?B?MCtFWUVkeldhYkhlSUpDVjJvZDlaZmwyUnA4M0JHaTNzeFpQVkpTM1ovRi82?=
 =?utf-8?B?a3VMZzUvamYyVTc0TE5EYWh1aHFRNml2elRMdlU1NnVTeWE2amlEVGhBSVNH?=
 =?utf-8?B?cGVPRWJTMVQ2L1ZoR0dMaXVIWGR0Q2tKbFRJZUVFSkVxZWE3UFlZZ3VVb3By?=
 =?utf-8?B?RmFPbWlOMmdvcDZYdGVkdXpUUlNEMjc2N3BRenBXRnFQbkJkcy9tem45dlIr?=
 =?utf-8?B?QkdlYnphb1NPcW5wODVOaVBuc3NrV1c1bzlVNytFcmNjMWIyRmpLMW9YRE1v?=
 =?utf-8?B?VkF3cGh2THo0dHZpa0k3ME01RllXSkdtYmNXeEJoTjhsbWlGTFlDOWZBUzc3?=
 =?utf-8?B?bUtua05KRkwvSWVhMlZJY1ZRQndUSlVaNDhGUGJZdlJXVUNXSUh0dEh1d3JP?=
 =?utf-8?B?U0NYL0hnYkkwdy8ycVVuUTFkbnk5enhsRngwM1VoY0hrYkNUWE0xN0pEYkND?=
 =?utf-8?B?UE1XaFhVWkFWbThWMDVIRjlDbEdiWDZxYUEzeFgwdmpkZ1l1V1dLTE9zWUht?=
 =?utf-8?B?Rys5R0F3cXF1N0lURkpmWlNrVVlOYStDeEJuV0JFaDdhazFqRUNzSnZza1Fn?=
 =?utf-8?B?bHlBb2hDVGQ2WHdDRVh6cWsvbmo3OElxeXJtaEpYaVJwV2RJZUlrMC92dXNu?=
 =?utf-8?B?M3R4SXJ0dTlvOGNVa2FHa3M5MWRaQTRCN21SbEp1WTA2WXQyOU5VdDd0Q0cy?=
 =?utf-8?B?RzRMd0VxZ2tWVDdwMFhtOERpd0MxRmtpM2luR05VVU0yRG5WTXY0MkpaRlBJ?=
 =?utf-8?B?Sm5KYVBQMS8rYnZSNXViNjQ5Q0ZqNHFjenNEc2NLd0ViR0J4c0kvaE04QlBa?=
 =?utf-8?B?alZGcnFwd09sVXdoZFgvNkNnUG9lMENCWFhoUGFTMzdtUXNxMTh6eFIwRndk?=
 =?utf-8?B?cGQ5bkRYVkliUlY5MENqNkVUSHVkNk42amw0NGFmZVdrM1VCSUFuaVBQbUlC?=
 =?utf-8?B?cC82TGdjWjQ3Vng5SGV1OWk2aTV4MThwUmRscjBVcytmMXEvWWpDTVVXTFJZ?=
 =?utf-8?B?QjVvd3hGSEJLYlVzOWlNa2xra0xWVkI3R1pzT29GSHoreHRISDlpbXo3a3dZ?=
 =?utf-8?B?NUpHVnZVU3RrdUI1OFNVMmx1SVp5MGxxK0ZidisyUU5GbGk4Y3BYSis0akdE?=
 =?utf-8?B?WHJZd3pCaCtqVVZRdllrNzVqNkFxZER6MTFBNUZ3TUFKNGd0N2NXMDNPcDd6?=
 =?utf-8?B?bVdpTUZleUttb1ZWS3lpMlVMSGg3TzBmNS9ZWFJESHI5YmJGTloxdFRmYThS?=
 =?utf-8?B?UG1TWERQWW1VWjN4c1BJRldrbG1YWDBqcUhVNyt0ODBIUTZ3cy9oYzZ3MG1O?=
 =?utf-8?B?OWR2WjFQM3J1Q1ArTXZSMU5XV2R1MHI2ZkRxZVZKRVlGeUk1YWluM3RJNFRl?=
 =?utf-8?B?aURiUnRIMll3MHJmNEMwNjB6RmlCSTVUVnJwSlExVm5Kck9zS2tuZU00R0p5?=
 =?utf-8?B?NXUxRno3LzBSaldXaXFwaHVXUXhKUm4xTklWNVkzeW9oanpKMnlVTFV2aU15?=
 =?utf-8?B?VDhrQ2w3UlJQVjJtcXpKT2pndzhPV3J6UG9JQ0kwZ3lZMDVVZGRJU1oxY0dT?=
 =?utf-8?B?MWU2ZS9CNDlZYlpnaEZ6QnM2SG1BRlVIOWtudW9EQXlPNEN4bUtUeGRFZENl?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dvXbqUyy8Z5PV2kwXfrjTIj6V60r7Kjqfznx7YMgsR4aYgmnlkHWNiD0n1rSc/EYyEDxYmc7u6QBffwtWvfexzaQ2JXesbIADkoSrXXj9AlaP2iIqqzpx/jPrixNfqit5Dj1Utl1WrHk96y8cDl0Dq6pjg+FpUCCOClL3ei49Ug88Rml3O042CWx69wqxQ/fkipra031/28EDeardyQaqNEJJxOxAabgVrj84t+4pmdizJsR+l9Js15f8VOvr9J7hlUUsMxeDRs4LV1Mp6v6eHhsmnnzba6dtMvzWj26A3RnzQHVfxGDCXv/pumB7yLRlA1Lm0Fd/ZWEXX2UH7gvu1++xHkwqDddA+v/eyDRrFkRe0B4qQeWLAx5IfA3sdAoYLS05QP0duDBEAP/IXn+N/3W02j+gjIB+RRtSr2jZXHB5lSF2BPuEUBFhF6E1cF4Bx/4IxIfs+o6FxZVeqbcLaNJ2yjOIlAQvf06m3VB2G2vPYDvLqPxh2IUIbFduLLyqHDD4on2mobvQX/cAL08kyp3D7Cu4nxdRdW8AhJ64gZydWvFoyUo4NzSqRDi3wDT/pnOwpvjzr3nlU6Obixrmh9DiIbJ8CswQlryxoNtCsnQXvKqwsAiK+jBYl94Yexbvx37XQIz8MsAM78y4p9hOiewBbYC4mv6e88WJ8tQMo/sEihQK6nayQ5NzfT3YA1jRDuENctmUkqHGyfCRk0kI8m4phKHLuSGbKH6GFfdkF3In2B38EBAwZ3K2UP0yLVjFkHy3m5serPhTyR9MTb3WZG14Oqx4DUMXX3vMXMv6i30YJEjw1frgLqGr6b8lBbaJwvP1n1KFC3k1n72hVrfku9u0O9dOhD5uGFnNVEiAWC7NJuwc8ilfuygJ/4u77Rh
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aaf4126-45ce-452b-2883-08db6e3dd489
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:46:44.4065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDAiRvQ5+6wdfvnqUaG0mpx8MH5Ekwdfia2Ae9nnsPpTJ8cupnwjScuV107gxhBmUuUfmh1IpeavITPp692YisEWdx0gD8AHCiDv0eoMdCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_04,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160068
X-Proofpoint-ORIG-GUID: yr_O12P0ZbPR-cP8N0iGNohO5GxzAuCL
X-Proofpoint-GUID: yr_O12P0ZbPR-cP8N0iGNohO5GxzAuCL
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 6/16/23 03:59, Shuai Xue wrote:
> On 2023/6/15 23:15, Yazen Ghannam wrote:
>> On 6/14/2023 10:12 PM, Shuai Xue wrote:
>>>
>>> On 2023/6/14 23:09, Yazen Ghannam wrote:
>>>> On 6/13/2023 10:19 PM, Shuai Xue wrote:
>>>>>
>>>>> On 2023/6/13 22:11, Yazen Ghannam wrote:
>>>>>> Currently, all valid MCA_ADDR values are assumed to be usable on AMD
>>>>>> systems. However, this is not correct in most cases. Notifiers expecting
>>>>>> usable addresses may then operate on inappropriate values.
>>>>>>
>>>>>> Define a helper function to do AMD-specific checks for a usable memory
>>>>>> address. List out all known cases.
>>>>>>
>>>>>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>>>>>> ---
>>>>>>     arch/x86/kernel/cpu/mce/amd.c      | 38 ++++++++++++++++++++++++++++++
>>>>>>     arch/x86/kernel/cpu/mce/core.c     |  3 +++
>>>>>>     arch/x86/kernel/cpu/mce/internal.h |  2 ++
>>>>>>     3 files changed, 43 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
>>>>>> index 1ccfb0c9257f..ca79fa10b844 100644
>>>>>> --- a/arch/x86/kernel/cpu/mce/amd.c
>>>>>> +++ b/arch/x86/kernel/cpu/mce/amd.c
>>>>>> @@ -746,6 +746,44 @@ bool amd_mce_is_memory_error(struct mce *m)
>>>>>>         return legacy_mce_is_memory_error(m);
>>>>>>     }
>>>>>>     +/*
>>>>>> + * AMD systems do not have an explicit indicator that the value in MCA_ADDR is
>>>>>> + * a system physical address. Therefore individual cases need to be detected.
>>>>>> + * Future cases and checks will be added as needed.
>>>>>> + *
>>>>>> + * 1) General case
>>>>>> + *    a) Assume address is not usable.
>>>>>> + * 2) "Poison" errors
>>>>>> + *    a) Indicated by MCA_STATUS[43]: POISON. Defined for all banks except legacy
>>>>>> + *       Northbridge (bank 4).
>>>>>> + *    b) Refers to poison consumption in the Core. Does not include "no action",
>>>>>> + *       "action optional", or "deferred" error severities.
>>>>>> + *    c) Will include a usuable address so that immediate action can be taken.
>>>>>> + * 3) Northbridge DRAM ECC errors
>>>>>> + *    a) Reported in legacy bank 4 with XEC 8.
>>>>>> + *    b) MCA_STATUS[43] is *not* defined as POISON in legacy bank 4. Therefore,
>>>>>> + *       this bit should not be checked.
>>>>> [nit]
>>>>>
>>>>>> + *
>>>>>> + * NOTE: SMCA UMC memory errors fall into case #1.
>>>>> hi, Yazen
>>>>>
>>>>> The address for SMCA UMC memory error is not system physical address, it make sense
>>>>> to be not usable. But how we deal with the SMCA address? The MCE chain like
>>>>> uc_decode_notifier will do a sanity check with mce_usable_address and it will not
>>>>> handle SMCA address.
>>>>>
>>>> Hi Shuai,
>>>>
>>>> That's correct.
>>>>
>>>> There isn't a good solution today. This will be handled in future changes.
>>> Hi, Yazen,
>>>
>>> Do you have plan to address it? If not, I can help. We meet this problem in our products.
>>>
>> Yes, definitely. The first step is to update the address translation code; this is progress. Afterwards, we can find a way to leverage this in the MCE notifier flows.
> Look forward to it.
>
>> Just curious, how big is the benefit of this preemptive page offline in your use cases? That is, compared to page offline as part of poison data consumption.
> There are three aspects of benefits if SMCA address detected by scrubber is offlined
> in advance:
>
> - Free page: it should be isolated and not allocated by buddy so that the poison data
>    will never be consumed.
> - In-use page: the heath VMs could be migrated into other heath node if many UCE occurs.

I would also like to add that an application able to take action and 
re-create the impacted memory page (like a database for example), could 
do so before the data is requested by a user.

> - Mitigate the possibility of nested MCE which is a fatal error.
>
> Thank you.
>
> Best Regards,
> Shuai.

HTH,
William

