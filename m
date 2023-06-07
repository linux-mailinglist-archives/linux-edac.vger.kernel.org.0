Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4DB72619B
	for <lists+linux-edac@lfdr.de>; Wed,  7 Jun 2023 15:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbjFGNrq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Jun 2023 09:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbjFGNrp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 7 Jun 2023 09:47:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FD01993;
        Wed,  7 Jun 2023 06:47:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLH2Q0eiKaWtDFBj/ZsCqTfpL7qxNKauekflhcvBQ2urWEnSz26aQyINhJhNVEr9aaHc7icjoOK40uS+82im89JsLjZqB3RMfq6SyoQsJp1ngW1HnocFqSo0H1abQysxZyrMw/KcjUx47GMt3tgctuwDU2QLrz0/+NFtudqAcgKVnj22ZmWEb8Jihs11+wt1ufOT0utdWINa8wUsIpDQ9tVvafwfV4S2ml9g7bqH1tVc7HlQBVeajdrTRrJwo9d0Sckbd4sw0+iiFEihg4jGQE5nd3LiQzu+zILECYVKD0UIn13O4aGJsNsSS5DSKljMkEgnFQ9l9wFwN2cxaxtM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzzQl71VrMSHAgl9EdVJ+7sxVrqoY7kWzLSrBUg8weQ=;
 b=kEA2W5DcocY+O/LCOPZ0AunPaF7nrDLj9UjSNuijL9pftWv1SuZ4DWy8KTIAdDJxszxWCRlbfUkl6PBs86QozNR5JuO8Plzf3zyZtBNOvsh3/sQ6abmeTnQnE1cO/8RyKS7E1FSiRtHEvFDt25Am5ynmT/5bGSsGJmnIbKUU6MJyAJtgd91KNCowD+ZXmwn3L2v0ofDXUnCsfuY7luXsFyUd4iFg9TkkhY0fZWKTaJH7bs+Vy9h2c592QMXNTBOXUATs2TA6LxOHNqj0HEwawTiimUl2ug2S1xX5ki+nSqDAU+uw1nvsKalHOu2eGiMd0WCjfCZlo8QS2WWg8tQBGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzzQl71VrMSHAgl9EdVJ+7sxVrqoY7kWzLSrBUg8weQ=;
 b=sfjoBap4W0auTWD8CvX3o1lmiX2psaPAxCePcs4UukLuOnn731oMCcUdSlkZEI+7Y7PE84eTcHi5fGlUvNZKElwRt/moGVMNFjssdU9OW4prKWP8GT81g25DVhh8xlc4F6MFuaPuGwUz/g4ByPlFMrJgevlu9rYVXs/Ncdi70lA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 13:47:40 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ca6a:7f77:6bb7:17fb]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ca6a:7f77:6bb7:17fb%3]) with mapi id 15.20.6455.028; Wed, 7 Jun 2023
 13:47:40 +0000
Message-ID: <0b8c44c1-1456-5d3a-5db7-00b67a5e4960@amd.com>
Date:   Wed, 7 Jun 2023 09:47:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     yazen.ghannam@amd.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        mingo@redhat.com, mchehab@kernel.org, tony.luck@intel.com,
        nchatrad@amd.com, Muralidhara M K <muralidhara.mk@amd.com>
Subject: Re: [PATCH] EDAC/mc: Add new HBM3 memory type
Content-Language: en-US
To:     Muralidhara M K <muralimk@amd.com>, linux-edac@vger.kernel.org,
        x86@kernel.org
References: <20230523085550.391768-1-muralimk@amd.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230523085550.391768-1-muralimk@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:408:94::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9647ae-c177-4908-7f7d-08db675dc325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sXiyANJ1sgSTcCuXswYQaoQaUqhIvvFMlSFtKIBmMPOeEkEy+n+rMDLTcmKvyp+QLqd7RfDAFttkCeBQa9n/TC5O7ApjemJwqcbdC7zxxAesp6Xrg2cduV9HjYRKYGfLTjoXgWFLPVRHH5+6PjdiXiAgYkDPvmxs1DSVSqPAdW5MzvQbtfAvTU2XYhi9lVonlQ7+VoqGF5KzQ29Q5xqULMKEG0yhMtpwQ4igN2woMIguUMXnvegmXtGr+9xHEIYASj+u6kVMIVAuY2hDJAztnHL1EzeYj2f8hbhfbDYRkrc+ilmA0ncy3TlOsAK5yEfeQ2PjGS8z2trRNG/07P6hDhbDPKlaMVZn1dJ6LzRNp5vSwd9fxt47SBdNq43Pdnd7vSC/O8V7sWRhnCxzI+m8Ntw/piPZbrnnUqhgiYDtLEp6kypXqUiglVRcDVw/GwBxm/qi7L9wdYz5eNE0PdFaHEaixzo0nijmJNIIvCLT6qLUMUajv/uaO5njncb6PxGmGhpMQ2aUEiwp0dYHtbicb56i7VFBvu88ZayoKuO8a/NYR3hxlHwGBt4i6qS+rju4jL1F42gmcC1i8doPuIYegoJkXLlc5r8JUmh3V6f2JxXsrBQT4ssHsCnhwsW8MGioO3crakd/e1CEh2hEN7wz/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(86362001)(478600001)(44832011)(8936002)(8676002)(316002)(41300700001)(66476007)(66556008)(66946007)(38100700002)(5660300002)(4326008)(31696002)(4744005)(6486002)(6666004)(36756003)(2906002)(6512007)(26005)(186003)(6506007)(31686004)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWtiWUdxbXl4VGk1L3EvUnJlZ0g4cmY4ZTFrMFcwcitQa3FxSzJPUmFGVFB1?=
 =?utf-8?B?K3A4TEVKREY0dk1DL2dEd0R6bjR2aDVrUnQ2ZFMvVUxvb2xkVzdXZ0tIVGtK?=
 =?utf-8?B?emZuTUxKVlV5aEwydjZGMEhmbFNSc1hOazkvUG1tdTU3bWF2Y0Vsa3VENUlz?=
 =?utf-8?B?T0hqSmlnWjJ1eXU3TFQvR3hlR2NtVzJ3YTdMOEgrZ2tMaEtYRmUwRHV1OEE3?=
 =?utf-8?B?RDdsdWxjblpqQTNNSk5MTnZjcFVuSTE0bElDdVJPQUtDZG0vTlVKeU5tRWJO?=
 =?utf-8?B?R29ZQnJRdXk5Z1NGMWwvMXpOWDkyRjR6QkNJQVN2ZTViQVFrakV0RDdMaEps?=
 =?utf-8?B?NGxQKzkxUzNKcFpJNTJJdURpcXhJbWN2QjZ0RzdObzJXRFpoTUF3MWk4V2sw?=
 =?utf-8?B?RUJWRmEwVExYSEVEWFl6ZG1PY2g1ZlQwMlovYkh6ZG1QWGN0RFo0dmUxaGFB?=
 =?utf-8?B?cjJuRS9mMFIrQlRZK0JhcG44WTZwd2RRQzlhZzRqT1VNN1JhS0srODlJMUpo?=
 =?utf-8?B?R1lIbVFFZEpYeGJkV1I2NTh0dEdzbDhucTIxV1pTSzlQTlIrMzhmSWtvYmRT?=
 =?utf-8?B?WGFxbllmOEN2Y0FBcUVQdWtQVExWRHp4MWtFcXQ3VzBES2NSMDlPeUYzbkUr?=
 =?utf-8?B?WDJZZy9LY3VLeEZCamR3NEpPRHZXNmRscjBsMWJNc3ZscjU4QnhpWEJVOUZQ?=
 =?utf-8?B?WkhzelZkWkkwTm5PSGdoaFp2ZUV4QVMxZ2lIUzVHQzRlV1hWaHBPd2VGTzBh?=
 =?utf-8?B?R0x4L1Zmdy9wUjIwVG16clFCaDlhK0xabnpPTXpnL3ZYVXB6Y29yMXZTQkxm?=
 =?utf-8?B?VW9PejRwdXFkUFN4QWJZUVhCQnVsODVWa0MrT3AzOWJpaG1ubUh6azYwUEZH?=
 =?utf-8?B?R3pyb1RUdnlSMDJCUGJPWmV3VmIxeWs1dFdTMy9haTl0ZXF4M0VIQTM2UEJS?=
 =?utf-8?B?d1cyMkNBTGVSWHIxNkp1dGExQ3B3d3NFUmt3TU9yeU5aOE0ycTB0TlZUNWts?=
 =?utf-8?B?ZnFOWVlKWGVRZzZwQ0VXaGY2SnNWeFQ4enJBK1lWbVRrSVZGSlZtY3kvbkRV?=
 =?utf-8?B?eTV5ZWt3bWU4NTRtSjlYK0piZndNcXlZbFBRaDJZbUV6azQxQXFGTTZSNmxF?=
 =?utf-8?B?RzJDOEszOHpJelJwcmtZV1MzR3E0UGxBQ1lkSTV4cjZpUC9SRmFvNlM5bU52?=
 =?utf-8?B?M3MvNy9EZ2xMblRhUGI3eFJoZ1VQRWZDRXByWFdxUjJaYVBDSDV6RjZmOVJw?=
 =?utf-8?B?RllpNTBGaVkrRFpSS2tzcmphUFNxZWlmbWNDWE55N3oyaS9rZU9ucjlrTHhF?=
 =?utf-8?B?Ny9XQXhrZ2s3aTBtWktWNkZ4UURvdGsxVkNuUXNvWW1SaXQ4aTBpVWJyZFZu?=
 =?utf-8?B?Vk43cjFVMXRnN2tlcUNxTE5pWWdpOEJaVklJZVJzTmpvOCtFVGtkNnZsTXZQ?=
 =?utf-8?B?RWRndUJYdDR0amljRGFtbjMvYmlvK2R0VUFXRWswZzBNbjhGUmRrOEgzVDRm?=
 =?utf-8?B?Q1J2NnNqYzVuc0JiUkJ5ZTVzd0h4L05UTWN1NVFBemszNEsya1hKMkF0VGM3?=
 =?utf-8?B?Yk90aC9jMkR0U1ZOMmlvcytjNkV6WllObzBZN255OUp3WjAyMFdrcFprY0Yr?=
 =?utf-8?B?TGp5WXArTzlzT3FISHJQaDZnWkZ6dkp4SkNlbTlHaFpJKzVmem9KNjJ2YmJL?=
 =?utf-8?B?TlhvN1RjMFlOVXgvdURTN0xMVE94SlFWd2o1Z1k2QlR1RGZ5NEpnYytHNXhJ?=
 =?utf-8?B?S0hpM3Y1a2pmUG9rZkdVVnpES3NnUzRJQkoxdEEyajZ3WE1SWGcwaCs2UEtm?=
 =?utf-8?B?MGEvVHR2cjE0dUNXVDB5SzFBQjlpWmlYbHNKVXB5VENLMU9PcGtpdWx6R0pT?=
 =?utf-8?B?a3RIcXB5WCtjejJNWTY5Tkpva2k1YWNsNFRFbHM4M0JlVHMxcHFlai9ha2Nh?=
 =?utf-8?B?eDl2NkZFK3hHQjgvcmhidHo5TFlCdjJMSWNXTmRuRytZZ0lVaVlzQ3VscTBK?=
 =?utf-8?B?a0g2b2daM1FCQ0xXU01uZDEwdjA4Vmg1MTZBcXJaQ1RySXJ4NURXQmRZTTVF?=
 =?utf-8?B?VGxubVVmdHZuamFlbXF1ZzE4QkZndG1zVmdPVFRqbm4yckpoYUJJVlZtOWpD?=
 =?utf-8?Q?r89ZXm4Z/hsOfS2KU12cNfxf3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9647ae-c177-4908-7f7d-08db675dc325
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 13:47:40.8470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fUtDBGqsdiHeuIX2HM8IjDedoOAkrCg5WWiuWbhzU1dF94TarjjzXlWkOU2g4Boc0WJwrMHkJhdcqbdI5R8Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 5/23/23 4:55 AM, Muralidhara M K wrote:
> From: Muralidhara M K <muralidhara.mk@amd.com>
> 
> Add a new entry to 'enum mem_type' and a new string to 'edac_mem_types[]'
> for HBM3 (High Bandwidth Memory Gen 3) new memory type.
> 
> Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
> ---
>  drivers/edac/edac_mc.c | 1 +
>  include/linux/edac.h   | 3 +++
>  2 files changed, 4 insertions(+)
>

Hi Murali,

This patch is completely within EDAC, so it's not necessary to copy the
x86 or TIP maintainers.

Also, this change is not currently used, so the patch should be included
as part of a set when it is needed.

Thanks,
Yazen
