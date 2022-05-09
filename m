Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C27D51FE7C
	for <lists+linux-edac@lfdr.de>; Mon,  9 May 2022 15:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiEINlr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 09:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbiEINlp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 09:41:45 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2123.outbound.protection.outlook.com [40.107.93.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3A5E00;
        Mon,  9 May 2022 06:37:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9rQ/0TfLCQeh+8SoHP97HOW6rTt5dvoblNM2ULSHPdFkKnxvIHfR9SDDtmHU/GwN89E/dkqve6SR05w2TfKwc24U1t4a6nPML6xk7UudZPb/yoKD5Sv9tm7UjcB6JgDyzXcII1wJAnrZLawZ9LYdUmEe+l/pS6h7yjV0UvJkK+92n6SMO1iTkhhHmvrGvmkAktuFwsZhEvf6scYSNKJxyQx3fkRI7yIViF+3OL3U1ReDkpD4BjRagtO3IVm2iH8EqUy88pFUnus3xUf6l7PRJMgj4SeHdZkieBD70oN4SrylfZnbnDj2hrAD8sfCkgOzyxX9i7BTFhIchoLPSYG1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ff95JI19/gyQEjNfUa/WYjuVRsBll2sRmhFrmNGnG4A=;
 b=J80IPaIk+YZayDjbVm9ktkUHngrBwneD2kDFF5ondAlmISKQsp3IqxBsDTXvpxVx2txYkHYoQGM9yFVSwmV1EVV7PaHwS0d8YK0IySfemFfNhCr+XZ/DFyqyPAMEkkB0fY6BEi1rjvR58KPtUDw+/K5pWtt0EQ9dySYx7HTIVUnuLysCgg7EajeVp+gKjlVGQOa6ogMKDOuYeh5gl1vfXsChW8oQRQDjh2euExKCK8WcjCb7H/DJBi2+3QXvLQ+KHn+i0siFWeF5esZnAjhV24PvZPvayyzoQs9N6h1ExRgdn4m+4jAO4E2nIDg2kZeDGaedw8lQVDAHns/gXZKKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ff95JI19/gyQEjNfUa/WYjuVRsBll2sRmhFrmNGnG4A=;
 b=xno+wTw9gl7B/ia0G64NDWcCjdFUdbjNJ2soJevwkYOlkkc99936JpBa0xX7w7EJN8MHYSrC19QiCG/CdGf2O9i1PD9k/WtJv0MTX09Rmob799Zt2iFybNfD1EqdQNPt8htnrlKGOazkGkvEiA1bsMscpy/I+raEw3wVxKisHIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH7PR01MB7608.prod.exchangelabs.com (2603:10b6:510:1d3::5) by
 DS7PR01MB7590.prod.exchangelabs.com (2603:10b6:8:72::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.21; Mon, 9 May 2022 13:37:49 +0000
Received: from PH7PR01MB7608.prod.exchangelabs.com
 ([fe80::e8eb:b7b1:f812:8ce]) by PH7PR01MB7608.prod.exchangelabs.com
 ([fe80::e8eb:b7b1:f812:8ce%3]) with mapi id 15.20.5164.020; Mon, 9 May 2022
 13:37:48 +0000
Message-ID: <7413d707-93a5-3681-e338-adebef198ec5@amperemail.onmicrosoft.com>
Date:   Mon, 9 May 2022 09:37:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] ACPI/AEST: Initial AEST driver
Content-Language: en-US
To:     "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>,
        'Tyler Baicar' <baicar@os.amperecomputing.com>,
        "patches@amperecomputing.com" <patches@amperecomputing.com>,
        "abdulhamid@os.amperecomputing.com" 
        <abdulhamid@os.amperecomputing.com>,
        "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "alexandru.elisei@arm.com" <alexandru.elisei@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "tabba@google.com" <tabba@google.com>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jthierry@redhat.com" <jthierry@redhat.com>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "zhangshaokun@hisilicon.com" <zhangshaokun@hisilicon.com>,
        "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Vineeth.Pillai@microsoft.com" <Vineeth.Pillai@microsoft.com>
References: <20211124170708.3874-1-baicar@os.amperecomputing.com>
 <20211124170708.3874-2-baicar@os.amperecomputing.com>
 <TYCPR01MB6160D05580A6E8C9510D25A5E9709@TYCPR01MB6160.jpnprd01.prod.outlook.com>
 <9330bbfb-d016-0283-a5ed-e2f4d5446759@amperemail.onmicrosoft.com>
 <TYCPR01MB616007723D2C8BA08F5337D2E9F59@TYCPR01MB6160.jpnprd01.prod.outlook.com>
From:   Tyler Baicar <baicar@amperemail.onmicrosoft.com>
In-Reply-To: <TYCPR01MB616007723D2C8BA08F5337D2E9F59@TYCPR01MB6160.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR15CA0029.namprd15.prod.outlook.com
 (2603:10b6:610:51::39) To PH7PR01MB7608.prod.exchangelabs.com
 (2603:10b6:510:1d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bedd3fa-ac04-4387-8f43-08da31c11b34
X-MS-TrafficTypeDiagnostic: DS7PR01MB7590:EE_
X-Microsoft-Antispam-PRVS: <DS7PR01MB75906AFBB11402A3849515AAE3C69@DS7PR01MB7590.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7gjFDem9Pa3oY90FHco0El2DelbD9gEUKhhKZL6XPmVBUs3jeY7Yl7amB52SpS3P/4WLoeyVeUuONwS5zgJc3qaOYtetltGx8eHAPAmnnOSn3sTlZ/NljENPpEaay1BuiYRGqA4Lu95j2TbjGTiEcB51+CceVZjQLmi+A86MadqG/D/jpIDT5mKU2oBOiDeGuyeq+YdssiD+RWmMYGwlSLKFxE3OaA6hIpOBoAcyUevh8Xihji7AEkVjWb2P+JRkpayXzyLMgbYVc8jCQKTvqKh39W47RViM3aLn7jcl8fqT9gAFgXasR+VkKKcmsTr7ia5l0avzyMeS3m1u31DoL2CNZZ/0HgWYMW0WGTQefOS9Z0iQA1Cpza5cCI6Xw0xVgemrnVRonThdkCbnhN6DI+PbnQNV+3I4omw56ZlosswehKBYJlNMBOKB1nJEoccF55A2o5cshE+qFl+a9A6WYVOxdVhzPqbccEKcLKnsnrQdLYqLDOUOYAL3BTI6Mq/u/UXSs5guUi2OF+xTPK2tSp47lKMq4QKcjgMzvQ5UK7ccvKH0WAOWtZLjgBT6iKLhaZbopem/0KSFBcZRZZyiIvGKWJVInlC6brz0KDBdqbvB+z9bQesGEPtTvGm9VfzhFyyUcRXybgsHVu4kvTiEVe0Z50ZRkYkobOGPcPCpGSmRMBhcZe2ObUp0YF3QjVbOVet5pMn3tbc8Sj8olg9UEVqI/lsziNW1NC4Y6sx0VJLSVNRw/yeX0dVoLQgGsRFU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB7608.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(83170400001)(8936002)(7416002)(7406005)(31696002)(66946007)(66556008)(66476007)(5660300002)(8676002)(26005)(186003)(921005)(316002)(42882007)(2616005)(2906002)(38350700002)(38100700002)(53546011)(6666004)(6512007)(6506007)(52116002)(508600001)(31686004)(83380400001)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTQ2QW1ka3VqTS8vSnlBc0tVdFhLbHFMd0kwa0hIQktUdGQyV1ZmNktPd05I?=
 =?utf-8?B?Z0RsSzNGTUs1K3FuWFdxVzVRRTQ5d3Z5dmZBWTVlUHZhZnRuS014RFlTY1lW?=
 =?utf-8?B?TEhxeXM0OXBwNTc5bDBpbzlWZWdiL1VMWlM0VmdoNWRCYVJvODBEUWxWYm12?=
 =?utf-8?B?NTV2THQ0cEtEQndZeVN4U2FCNG9zTHU1UVNHZGk3VkNvZHY3Vmgxd3hDT0Rv?=
 =?utf-8?B?SUlXS0VqYjRTNkpZNTY4M1FmWlFvL2hubWM0eHYxNE8rV29JRG5qeitwZTNk?=
 =?utf-8?B?ZVJkK2J2MUVBTGRyTEZ2aFpTcm4rSmE1NnNjUzNlQVVhLzJtOVphME82TnJW?=
 =?utf-8?B?STFhWkVFeWt0NTAveVNJMW5nS1MrOUwvQnV3cnYxQVdreWt2N05Db2JZMDJP?=
 =?utf-8?B?YzVWVVFWR3VKNEFOand3bTdwZmFKMzZpWW1EUjE1aFdibmoraW0vR21zajF0?=
 =?utf-8?B?ZGdRdTVUQmRybGUyOStmYzFKR1NLVzRCS1lNclpKdmJMclhtZ2twdUREcWFn?=
 =?utf-8?B?MEpYSjlsU1g5bTZqWFczNytYWUpPMXpvdTByQWRnd05BWENSeEswdDF5SnF5?=
 =?utf-8?B?ZlB0ektQeDdsSitCY0FjT2FscnkxdGQ0dUV1RWhveGZzZy9BWllGOEc2bHV4?=
 =?utf-8?B?QmlKdzgwSlBQK09KRndxdHlSMzNyNTd5UTdvWWZvbElGNklKQTI1VE1WcUds?=
 =?utf-8?B?aDN5b05EV0NxV3U0WG9vKzRDMXc5ODFROTBKaFgzbUtZS0drL1dFL0NwY2RX?=
 =?utf-8?B?QXRKc0FWWjVDUWNGUGxEUVdvaXZIbEFrdlFpb3RWaVovdFpRSWthUFRSbzky?=
 =?utf-8?B?WnFyTDI1M0dTWG0yOUQzOUVVa2JrVFAzaXdxMXlHOTd6VHdwUWw1VnJMa1gw?=
 =?utf-8?B?eURkRSs3blJvV3dRR1IvaDJCZU5BVzFuNXdhdnBUZHl4cmRQSWFpdStjWEJF?=
 =?utf-8?B?NHNiNzA0alIwL04vYWxVTVF3T3pIREJxVnBpWHFsTFNlRW82VVhlNW0vTDZy?=
 =?utf-8?B?ZkNiMDZSVjFzWS9yWHhuSEJjNGZwNHREcmNQeTg1Q2VyUmZzTTc0VHlpdzd0?=
 =?utf-8?B?UmdLOUFqWDJHTzcrVUlWYm16bUpBaE9pQTBRa0VxQVpyN2pHTnYyWkt3Yzd5?=
 =?utf-8?B?RFFDcGphMStlRjMvaUpyVmpSclZwR3lRUDRJOWE0dnI1ZGFYYXJmc0xLclh4?=
 =?utf-8?B?TGo2aFZwd2JUQ21IdFVUTHJndDZOY2VSNStzK2VHcjNOcGl5aDZTdWpOVHRN?=
 =?utf-8?B?ZGdLZ2J6YVFIb1BPZ1doMkFYdzdJMklFVnl2em9DNUJLTy9yUTJ0cFgxWlJL?=
 =?utf-8?B?U0xWaWdHTVJxYURma2dOSUp6WjN4SHljRHp1V3NUYTBEaDhadjFKdlRLT2Zz?=
 =?utf-8?B?SW43STNVeHRiSGdUYk44bk5pTCtuRGtMUjRxam5ucGlETkN2QkZvdjBPT1kv?=
 =?utf-8?B?enFtNzNzOS9FV1RwRmFPT045cnhSZWsya1BmYytvWmZhb0FXKzVwM3NzdDhx?=
 =?utf-8?B?NHh1WkVUdjZmTnY1dlVGV3QvQXNjc052MlBNc01hb1Q2cktYNVMvQU95NWF5?=
 =?utf-8?B?OGtoTXBKeGtwRzFEYTA3L2JPa1BNdXhlZ1U1VCs0Y2EvME1oOFdEVjFqeTRu?=
 =?utf-8?B?NGVuaG9pU01nR0huZW50d21iMmg5NGpGWE1QeGtPWHFUdFZOL0tVSWRYYm1V?=
 =?utf-8?B?bncxbFZRc3dhVStpK0N5YlVVL0hrb1RCZXAza2hFUW83UXJqb0o2eXFSdW9B?=
 =?utf-8?B?YU5SbzVaS1RLNUlXM0FzVEdKdHNjN2tibWFFV3lTaUdQNnlDMWprUTBQQ2J2?=
 =?utf-8?B?VnlTWDRBTVI3dHBtQkZJWFFXOFFrMDRqNGRrZXZUbGZGR2VrV3hwZ1N5RzQ5?=
 =?utf-8?B?a2pPdndUd0FJTGF4YThqM0pJM1hPdjJOL1hXMTZpcnlyZEhYM3NSdUFDcFgr?=
 =?utf-8?B?ekNuaHVxSTUxdEljQzlNcXh1UUNsejNrbStmMTVuSmxwSGVQVjc1MXlHMzRT?=
 =?utf-8?B?U1BjbzJlbVJQWEYyYjJlWDE5Qzhudy9VSzlTUlpha1RudU9TblMvdW43bGsx?=
 =?utf-8?B?L3BXQXpBUXdqOFBuRm9ycG84dDVZck9SM2R0TExMV1RmMjltSmNWNDI1b3JE?=
 =?utf-8?B?eXlldjRIeG5mV1ZIUDlGQ0RRKzFoY1NzOGY1YnJtZkZOcHdUalJGdlF5S1dU?=
 =?utf-8?B?dWdHRnFzYnZBanhycWVCVFZ0WjNhYTBXaXMwQ0hHZlZYQkwyQTFXaGtMWnZp?=
 =?utf-8?B?RWpZL1pCQWdjNlRYREQrNG1XOGdnWGM1NnRVZHVMT3hjMUhzTzI1RnYwdU9m?=
 =?utf-8?B?dEMyMXd0cmNOQ1B4UzliN0JGdEY3LzZuajJLdExwaDdJVWhkZFlmR0RaOEpM?=
 =?utf-8?Q?WuzLvdlJOzKldddmTg5kgw4qUB/sBQ8jr8lAZ?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bedd3fa-ac04-4387-8f43-08da31c11b34
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB7608.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 13:37:48.8844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eDaicKRH3gyuXkmmufvqwfBv4b5k533V4VDoa3nCKdotZnPG6h8CbrqDfnwUWbTtSHOUz0imON/rd/3Ms98CSVxuKaYye+WeOb1D2OpERR+u9gHAryLexDNnoDEg9BC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7590
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Shuuichirou,

I should be able to get a v2 patch series out by the end of the month.

Thanks,
Tyler

On 4/20/2022 3:54 AM, ishii.shuuichir@fujitsu.com wrote:
> Hi, Tyler.
> 
> When do you plan to post the v2 patch series?
> Please let me know if you don't mind.
> 
> Best regards.
> 
>> -----Original Message-----
>> From: Tyler Baicar <baicar@amperemail.onmicrosoft.com>
>> Sent: Friday, December 17, 2021 8:33 AM
>> To: Ishii, Shuuichirou/石井 周一郎 <ishii.shuuichir@fujitsu.com>; 'Tyler Baicar'
>> <baicar@os.amperecomputing.com>; patches@amperecomputing.com;
>> abdulhamid@os.amperecomputing.com; darren@os.amperecomputing.com;
>> catalin.marinas@arm.com; will@kernel.org; maz@kernel.org;
>> james.morse@arm.com; alexandru.elisei@arm.com; suzuki.poulose@arm.com;
>> lorenzo.pieralisi@arm.com; guohanjun@huawei.com; sudeep.holla@arm.com;
>> rafael@kernel.org; lenb@kernel.org; tony.luck@intel.com; bp@alien8.de;
>> mark.rutland@arm.com; anshuman.khandual@arm.com;
>> vincenzo.frascino@arm.com; tabba@google.com; marcan@marcan.st;
>> keescook@chromium.org; jthierry@redhat.com; masahiroy@kernel.org;
>> samitolvanen@google.com; john.garry@huawei.com; daniel.lezcano@linaro.org;
>> gor@linux.ibm.com; zhangshaokun@hisilicon.com; tmricht@linux.ibm.com;
>> dchinner@redhat.com; tglx@linutronix.de; linux-kernel@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
>> linux-acpi@vger.kernel.org; linux-edac@vger.kernel.org;
>> Vineeth.Pillai@microsoft.com
>> Subject: Re: [PATCH 1/2] ACPI/AEST: Initial AEST driver
>>
>> Hi Shuuichirou,
>>
>> Thank you for your feedback!
>>
>> On 12/9/2021 3:10 AM, ishii.shuuichir@fujitsu.com wrote:
>>> Hi, Tyler.
>>>
>>> We would like to make a few comments.
>>>
>>>> -----Original Message-----
>>>> From: Tyler Baicar <baicar@os.amperecomputing.com>
>>>> Sent: Thursday, November 25, 2021 2:07 AM
>>>> To: patches@amperecomputing.com; abdulhamid@os.amperecomputing.com;
>>>> darren@os.amperecomputing.com; catalin.marinas@arm.com;
>>>> will@kernel.org; maz@kernel.org; james.morse@arm.com;
>>>> alexandru.elisei@arm.com; suzuki.poulose@arm.com;
>>>> lorenzo.pieralisi@arm.com; guohanjun@huawei.com;
>>>> sudeep.holla@arm.com; rafael@kernel.org; lenb@kernel.org;
>>>> tony.luck@intel.com; bp@alien8.de; mark.rutland@arm.com;
>>>> anshuman.khandual@arm.com; vincenzo.frascino@arm.com;
>>>> tabba@google.com; marcan@marcan.st; keescook@chromium.org;
>>>> jthierry@redhat.com; masahiroy@kernel.org; samitolvanen@google.com;
>>>> john.garry@huawei.com; daniel.lezcano@linaro.org; gor@linux.ibm.com;
>>>> zhangshaokun@hisilicon.com; tmricht@linux.ibm.com;
>>>> dchinner@redhat.com; tglx@linutronix.de;
>>>> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>>> kvmarm@lists.cs.columbia.edu; linux-acpi@vger.kernel.org;
>>>> linux-edac@vger.kernel.org; Ishii, Shuuichirou/石井
>>>> 周一郎 <ishii.shuuichir@fujitsu.com>; Vineeth.Pillai@microsoft.com
>>>> Cc: Tyler Baicar <baicar@os.amperecomputing.com>
>>>> Subject: [PATCH 1/2] ACPI/AEST: Initial AEST driver
>>>>
>>>> Add support for parsing the ARM Error Source Table and basic handling
>>>> of errors reported through both memory mapped and system register
>> interfaces.
>>>>
>>>> Assume system register interfaces are only registered with private
>>>> peripheral interrupts (PPIs); otherwise there is no guarantee the
>>>> core handling the error is the core which took the error and has the
>>>> syndrome info in its system registers.
>>>>
>>>> Add logging for all detected errors and trigger a kernel panic if
>>>> there is any uncorrected error present.
>>>>
>>>> Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
>>>> ---
>>> [...]
>>>
>>>> +static int __init aest_init_node(struct acpi_aest_hdr *node) {
>>>> +	union acpi_aest_processor_data *proc_data;
>>>> +	union aest_node_spec *node_spec;
>>>> +	struct aest_node_data *data;
>>>> +	int ret;
>>>> +
>>>> +	data = kzalloc(sizeof(struct aest_node_data), GFP_KERNEL);
>>>> +	if (!data)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	data->node_type = node->type;
>>>> +
>>>> +	node_spec = ACPI_ADD_PTR(union aest_node_spec, node,
>>>> node->node_specific_offset);
>>>> +
>>>> +	switch (node->type) {
>>>> +	case ACPI_AEST_PROCESSOR_ERROR_NODE:
>>>> +		memcpy(&data->data, node_spec, sizeof(struct
>>>> acpi_aest_processor));
>>>> +		break;
>>>> +	case ACPI_AEST_MEMORY_ERROR_NODE:
>>>> +		memcpy(&data->data, node_spec, sizeof(struct
>>>> acpi_aest_memory));
>>>> +		break;
>>>> +	case ACPI_AEST_SMMU_ERROR_NODE:
>>>> +		memcpy(&data->data, node_spec, sizeof(struct
>>>> acpi_aest_smmu));
>>>> +		break;
>>>> +	case ACPI_AEST_VENDOR_ERROR_NODE:
>>>> +		memcpy(&data->data, node_spec, sizeof(struct
>>>> acpi_aest_vendor));
>>>> +		break;
>>>> +	case ACPI_AEST_GIC_ERROR_NODE:
>>>> +		memcpy(&data->data, node_spec, sizeof(struct
>>>> acpi_aest_gic));
>>>> +		break;
>>>> +	default:
>>>> +		kfree(data);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	if (node->type == ACPI_AEST_PROCESSOR_ERROR_NODE) {
>>>> +		proc_data = ACPI_ADD_PTR(union acpi_aest_processor_data,
>>>> node_spec,
>>>> +					 sizeof(acpi_aest_processor));
>>>> +
>>>> +		switch (data->data.processor.resource_type) {
>>>> +		case ACPI_AEST_CACHE_RESOURCE:
>>>> +			memcpy(&data->proc_data, proc_data,
>>>> +			       sizeof(struct acpi_aest_processor_cache));
>>>> +			break;
>>>> +		case ACPI_AEST_TLB_RESOURCE:
>>>> +			memcpy(&data->proc_data, proc_data,
>>>> +			       sizeof(struct acpi_aest_processor_tlb));
>>>> +			break;
>>>> +		case ACPI_AEST_GENERIC_RESOURCE:
>>>> +			memcpy(&data->proc_data, proc_data,
>>>> +			       sizeof(struct acpi_aest_processor_generic));
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	ret = aest_init_interface(node, data);
>>>> +	if (ret) {
>>>> +		kfree(data);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	return aest_init_interrupts(node, data);
>>> If aest_init_interrupts() failed, is it necessary to release the data
>>> pointer acquired by kzalloc?
>> aest_init_interrupts() returns an error if any of the interrupts in the interrupt list
>> fails, but it's possible that some interrupts in the list registered successfully. So
>> we attempt to keep chugging along in that scenario because some interrupts may
>> be enabled and registered with the interface successfully. If any interrupt
>> registration fails, there will be a print notifying that there was a failure when
>> initializing that node.
>>>> +}
>>>> +
>>>> +static void aest_count_ppi(struct acpi_aest_hdr *node)
>>>> +{
>>>> +	struct acpi_aest_node_interrupt *interrupt;
>>>> +	int i;
>>>> +
>>>> +	interrupt = ACPI_ADD_PTR(struct acpi_aest_node_interrupt, node,
>>>> +				 node->node_interrupt_offset);
>>>> +
>>>> +	for (i = 0; i < node->node_interrupt_count; i++, interrupt++) {
>>>> +		if (interrupt->gsiv >= 16 && interrupt->gsiv < 32)
>>>> +			num_ppi++;
>>>> +	}
>>>> +}
>>>> +
>>>> +static int aest_starting_cpu(unsigned int cpu)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < num_ppi; i++)
>>>> +		enable_percpu_irq(ppi_irqs[i], IRQ_TYPE_NONE);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int aest_dying_cpu(unsigned int cpu)
>>>> +{
>>> Wouldn't it be better to execute disable_percpu_irq(), which is paired
>>> with enable_percpu_irq(), in aest_dying_cpu()?
>>
>> Good point. I will add that in the next version.
>>
>> Thanks,
>>
>> Tyler
> 
