Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187B14D8BBB
	for <lists+linux-edac@lfdr.de>; Mon, 14 Mar 2022 19:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243866AbiCNSWY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Mar 2022 14:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243882AbiCNSWV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 14 Mar 2022 14:22:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876553F30A;
        Mon, 14 Mar 2022 11:20:56 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EI7n51009862;
        Mon, 14 Mar 2022 18:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IwLC+/A8zvJxpc/t55znxRGJZ/T6wfFIR0Yo90f+QPo=;
 b=OZhr5Wu7PV1ntVQGGk5EXaI7iZRebCQQJitYL19sEFhIpS6l30nDJP5koW7b5vMUB5bi
 d0DH189uIwLJnpvZfezJXmfNjuBuYF7+e/wUrsdzNaJxzH8jXNZ2SEKMiHqcJBNbsIDR
 mZURHPCi2ubauwiBQRPbEvtMfggcpaZ7OXbFa9eFf8SywNgm1wv4i0qqxpEmjQTzflXX
 55yx8SyeKK7xgzyQNsWAZ+cPguOiNDCRcCM82y9kSh1qW6PvUjoI7HWIunYYbeEq878k
 ima7ou/cRGvIkyZ6afnLFdJ+GDiLeTwwikcOFkNH8uAZTJJ4X4EBjcsxNf2RGe4OvGvp YQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwh1c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 18:20:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22EIFdt9013762;
        Mon, 14 Mar 2022 18:20:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3020.oracle.com with ESMTP id 3et64jdj8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 18:20:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8tFf47uxDHICmpp7QWkJRfdBxG8urxoSylu9GTDt94dofBiR/LBAB9vNj7EXNZXxO2GPESIzPBZh8qIZrtVLJAohYaLREyD6Q1fy51LlQ5fY23rGfkUldlOjDFBRaEV/2N19QsGuRhZ2OKIz5WAU12K0rX7Z0EoAaKpAUAI1M4dVuiX3RVBEJEBv9Tzzi3ETkYFEmgtv30v4dCF60lrvWR+zievHdZUHyY0yudSiimiyM322YpGiyQ2NC9sQSxcU5gsTYhLFFDBxk0IADLRvzXOVrYolsoY4xmgKT9YoBkcvASrfvUxpPNqrnV+MRFGpi6aDYUH+ShNxfxjIg62ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwLC+/A8zvJxpc/t55znxRGJZ/T6wfFIR0Yo90f+QPo=;
 b=LbKZKHOBNzSAKqrab4jwglXBF6Ck8m2zGiOwT4l3vXof+mGZKxkvh7eIWDxkfsXHOaP41EggbXbLLBlhzzfIWZohJ9eYansuXz39rKXU1bDu3P1jt3HhoZ5YU7dSUQnu6W/y7vkPmE7pOU9D+/Xfg+8dRofZhqa1XRK5vvhW/fwH8lKTiswyUQLndMPxjRU97YN1mVPJ5Ykyd6x4WnM/ZtZcRNBcqkr7Zpgyp74oWdN5sdlMmazha+MLRGI+YNKtwA1Zl9n1C3e2rbd74Yzbzx0wVG5+7Y3VeJXCsirMcpuWIkHeD4dmDsyH0qkCQrJyly8sSrPFn5x1nNBAOwVgWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwLC+/A8zvJxpc/t55znxRGJZ/T6wfFIR0Yo90f+QPo=;
 b=Xg2QtHdleYDYZrPkKI1x2ZSORJAI64xIGkZQNhQ0Ux6/YnVcg+wVm3dCsHlOturGq9d8aw2NaV0X5LwQYHkrBuvTXm2euQkdObInJOUTe5i3GGj1d7mT/VrwwBbTk2v3JR4V8Nlq5qIs7rAaTQGz/IqAsmibq4092g1oFdySvQ8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5209.namprd10.prod.outlook.com (2603:10b6:610:da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Mon, 14 Mar
 2022 18:20:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7%5]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 18:20:30 +0000
Message-ID: <91661cd4-e9be-959f-8b6a-da257a00a879@oracle.com>
Date:   Mon, 14 Mar 2022 11:20:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 1/3] mm/memory-failure.c: fix race with changing page
 compound again
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        tony.luck@intel.com, bp@alien8.de, naoya.horiguchi@nec.com
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
References: <20220312074613.4798-1-linmiaohe@huawei.com>
 <20220312074613.4798-2-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220312074613.4798-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR18CA0049.namprd18.prod.outlook.com
 (2603:10b6:300:39::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ec2e3e1-b2f0-4d7a-a0f7-08da05e75230
X-MS-TrafficTypeDiagnostic: CH0PR10MB5209:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5209038CD7D496AEC54185FAE20F9@CH0PR10MB5209.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZzcl1th3j7kc4pQcR1jzD2fKjxadOgY5skYAAwu9NQ75D0YWCJ7/Usg4/Jf66Az7DXItzavvxoS0xKelU5N3iJ6sCtGZnLP1XwnGSVgg0ibt+Ar0A0Xuarac4c09bJUoyNG7B3TI3bLqGDpgZ5Ys0G83qQOtLA8rKwqaae9Zq+DHeEcD3dxVaZxgA+BHSmR15mnnZ8NYXq8oen043LKOc9/+1zQ8JKAMeyBi5Me4Cpnlb+34LZWABtCEKlrdaTgbiI/J+FyswhH9hY6yJ2ZzZwFTpmp8tV0k4EGbd9jTZfoIZxT6I3nvL3nkRU18Dsz8kD2KX8uqsSvEd7beZjlJGksfsoS0FyBDddNzBfGk0GvM8LkW2EV6OlZ6AZ/tcfuCU3KwySqIwSrN9YNDWJ/A/3XxxxQOwcmGJ9IMpo/F5F9S8np51g+pPRR32HxVdMUvILx9tJV9pvwVZ3DsGuWWUebcYQfZL6F20XfBfbh6BjBepc/lKbP7vsGcZzfj3awILSRZopC55XB8zz986xOx4sBjg4OhmWlDSaqitC0+3YSKBAMkw7HbgSwEGIDMkURnzZQmPmwGSYQCT42Wl9BFMvl8s6xpGwudSpc7YFaPvxIB3oF8Iu7gyx82vSPIr3ElzAi4eUsLrewL2L0WrStWfZWKGrW63ljHSwXzyRFbyuHhfEaFQSKqrYhDhTfoFz8fnHZIRqLiRO9C2L+B0l+ONqDPcLxXJThDNheKoaNrTgtkLARrY6mHN2/d/JTPKyRZb4HHOs6NMywCn59dWPeLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(83380400001)(26005)(8676002)(316002)(4326008)(66476007)(66946007)(31686004)(36756003)(66556008)(6486002)(6512007)(508600001)(86362001)(31696002)(2616005)(5660300002)(8936002)(38100700002)(38350700002)(44832011)(53546011)(2906002)(52116002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0lRRURhSkpKdy9YTTlrdm9YYzhETktGZUhyc3VoQ3JSbjlZVEhzeXJoSzJQ?=
 =?utf-8?B?WURZWkw4MDZvK3FIcTI0a1NwWG9vNFhUU2ptSHhMVllySWZnamtDeHhTRnZw?=
 =?utf-8?B?cHhlU1ZGOFo0anB1aWZWOHIrNGdnbncvcGUxeHdKbDF6R3E3cXNZbEpMZGk0?=
 =?utf-8?B?aTJsRTluaUxyYVZIdjlOdEU0YWt0eFBkOGErYlY0UzBSR0puSHcvYVZiTHFN?=
 =?utf-8?B?QXpaL3VWNTlCWS9mUmFPV2dDaG9CUGNqQ1FvdzgrZDdVVVEwZjBzeW5XaE5x?=
 =?utf-8?B?TEEvLzFlUkRITmR6RzdrSzlrc1lybkFMYlFuanhzeVZMSXNzWVFvVWZHM1dT?=
 =?utf-8?B?TUJpL2R4djNubU0yU21HcksyL1JycGdJZVRCR3QwbmNjTjhjVkFhTmxQSkQ2?=
 =?utf-8?B?d1pUZlhwMXFFYTNxekhyRWkyMy96LzQ3OTUyNXFqdXhEMHhicTVGTnZiZ3Bp?=
 =?utf-8?B?WTBZWlNMZVJpQjlmMHFaS1MwaFZkOGVRR2E1bG00UzRWSnRKY3A4ckdSSVR1?=
 =?utf-8?B?NEZ0c0pDYlZJTERFbEo2ZUpLTUo4TWdRNy9hOVJ4aEZsTTBCeXJ1R3duQWJC?=
 =?utf-8?B?S1FicnRhWjhySlJYNytROXJkcEQwMTJ6bVpRYkhsT1VvS1l4akFub1JsaTlI?=
 =?utf-8?B?Wnd6SGQxT3BjamxlbXpBalE2Y1Q4anNzZXhZQ1FJa1ZES0RxT1FDNS9ROVgr?=
 =?utf-8?B?QTBsRFJOcXFuYXFVK2cvYjZWU251Z0RmYjAvVGZtL1AvcFQ2YVhxbXhBUnh3?=
 =?utf-8?B?Q000eEV0akhkS2IrR1AxbGxTb2pab1R2aGdtdk4wQU5Rd1hkTzUrNmZZNzUv?=
 =?utf-8?B?NjliT2JhUkk2NDd2SG1rMllSUHQyeFhIWFVUNUppMEY3UE81SFNEQkN5ZHFm?=
 =?utf-8?B?RVY0bnNwVmgvVVNwTXI5RjNuVDM3K1JyaGpYalI3bWxIMzlyem1WSHpmSkY3?=
 =?utf-8?B?MklpTEtITUpFYllmdm0zSE9FWCtPdUQxZzFpVWxLMVlXYXRlLzZPb2xxTy9t?=
 =?utf-8?B?UUFIeHJnNDdIMjZMTGkwMXdDdHVNL05tRWtldVJJS0cvbEdnb05SOWJEZFhm?=
 =?utf-8?B?a3NRL3h0Wk5CbkIyM1dwL3NWRHFiUE1lMXFNTmFmQWczSVI1YXRUUXFLR0NE?=
 =?utf-8?B?T0ozT0Nmc0F2dVA4cmd1Ykl4cEV0cFRsWEZ3eS9UbUF3MDAyRUtTNTk5M2Nt?=
 =?utf-8?B?aFhmV0Z3dXZsZmx6UnBqNThwaFhGelVtcEUyRVo0UWtYR09sdjUzOGxhdlVE?=
 =?utf-8?B?TTRrT24rbkdCaU5wQzk4OHVNTDZ1RWJyU2VRTFJjL01xay85OElPRnBIdGZC?=
 =?utf-8?B?SFZTVW83MzY1dDNiKzNnWFFHR3RmMFIwNHRSMU11SThLck0xa3BQU1pjYVo1?=
 =?utf-8?B?R09jL1V6S0tLbnJHS2FYTUdGWW9PdXc5YjUzdm53M0RvMXlVVDhCVGE1OUR6?=
 =?utf-8?B?RnpkTmVDK1NaZmN2aXRBcXhlcWp0a3hHQ2FBNXYxSEo2aldJcmkvZFRFdHBP?=
 =?utf-8?B?dFo1Q0R2aVhOS0UzRnRMcDhOeGJ5TFFpZ3RlSjZKcTBvcmNhMkt6ZG9pYW51?=
 =?utf-8?B?MkZ6bTZuZHhMTXJYSWFESUdsRTFCdlNzZUVsMG5JZy9RaXNob0xjYzBSQUpJ?=
 =?utf-8?B?SnFVdStoSGM0NFkzVVM4WDJ0UmhBZkErWWI3UHg3dUFwQnl6VWpqV2tXWGZS?=
 =?utf-8?B?aHArMDVhMlQramo2dFBjV1ZhMXFWOW1oNzNmU2JDNU8rcU5uZUR5clJEb0do?=
 =?utf-8?B?K0E5VmJIbGhsbisyZlZ2dTVNbzhzZGhkK2NFNkF2NkMwV3NITTRiOUZLbEQz?=
 =?utf-8?B?UVRsZTh1bm1WdHl1U0VkZFlGenZUa0t2bUVjeGxwdytUY0xCVjliR3RJU0dK?=
 =?utf-8?B?RWYrRjc1TW02SThUbFZIbFpodWZ6L1ZlUGhDc0o0Sm15S2loaW43V3oyWkJi?=
 =?utf-8?B?N0o2NkxTNFlsMkpDWW5kUURsaFF3S2RVbXUxa3M1WkMrMEg5dXlTeW1oeHU2?=
 =?utf-8?B?d2ZrZ21UZmVnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec2e3e1-b2f0-4d7a-a0f7-08da05e75230
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 18:20:30.2098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUET0G1JcB1Q7eLs3SJxMUZotnfQNh6hVI3sqnd+byoVKusRevmPPRdh0Txt9t3n6OGr0yooMUo2vrjS25+QRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5209
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140110
X-Proofpoint-GUID: EsMhBQ9I6MGc_1_1kpqakuxILim18hxH
X-Proofpoint-ORIG-GUID: EsMhBQ9I6MGc_1_1kpqakuxILim18hxH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 3/11/22 23:46, Miaohe Lin wrote:
> There is a race window where we got the compound_head, the hugetlb page
> could be freed to buddy, or even changed to another compound page just
> before we try to get hwpoison page. Think about the below race window:
>   CPU 1					  CPU 2
>   memory_failure_hugetlb
>   struct page *head = compound_head(p);
> 					  hugetlb page might be freed to
> 					  buddy, or even changed to another
> 					  compound page.
> 
>   get_hwpoison_page -- page is not what we want now...
> 
> If this race happens, just bail out. Also MF_MSG_DIFFERENT_PAGE_SIZE is
> introduced to record this event.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/mm.h      |  1 +
>  include/ras/ras_event.h |  1 +
>  mm/memory-failure.c     | 12 ++++++++++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c9bada4096ac..ef98cff2b253 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3253,6 +3253,7 @@ enum mf_action_page_type {
>  	MF_MSG_BUDDY,
>  	MF_MSG_DAX,
>  	MF_MSG_UNSPLIT_THP,
> +	MF_MSG_DIFFERENT_PAGE_SIZE,
>  	MF_MSG_UNKNOWN,
>  };
>  
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index d0337a41141c..1e694fd239b9 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -374,6 +374,7 @@ TRACE_EVENT(aer_event,
>  	EM ( MF_MSG_BUDDY, "free buddy page" )				\
>  	EM ( MF_MSG_DAX, "dax page" )					\
>  	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
> +	EM ( MF_MSG_DIFFERENT_PAGE_SIZE, "different page size" )	\
>  	EMe ( MF_MSG_UNKNOWN, "unknown page" )
>  
>  /*
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 5444a8ef4867..dabecd87ad3f 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -733,6 +733,7 @@ static const char * const action_page_types[] = {
>  	[MF_MSG_BUDDY]			= "free buddy page",
>  	[MF_MSG_DAX]			= "dax page",
>  	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
> +	[MF_MSG_DIFFERENT_PAGE_SIZE]	= "different page size",
>  	[MF_MSG_UNKNOWN]		= "unknown page",
>  };
>  
> @@ -1534,6 +1535,17 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>  	}
>  
>  	lock_page(head);
> +
> +	/**
> +	 * The page could have changed compound pages due to race window.
> +	 * If this happens just bail out.
> +	 */
> +	if (!PageHuge(p) || compound_head(p) != head) {
> +		action_result(pfn, MF_MSG_DIFFERENT_PAGE_SIZE, MF_IGNORED);
> +		res = -EBUSY;

We have discussed this race in other versions of the patch.  When we encounter
the race, we have likely marked poison on the wrong page.  Correct?

Instead of printing a "different page size", would it be better to perhaps:
- Print a message that wrong page may be marked for poison?
- Clear the poison flag in the "head page" previously set?

-- 
Mike Kravetz

> +		goto out;
> +	}
> +
>  	page_flags = head->flags;
>  
>  	if (hwpoison_filter(p)) {


