Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F484EDEE6
	for <lists+linux-edac@lfdr.de>; Thu, 31 Mar 2022 18:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbiCaQha (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 31 Mar 2022 12:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240022AbiCaQha (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 31 Mar 2022 12:37:30 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2064.outbound.protection.outlook.com [40.107.96.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20D11BD9A9;
        Thu, 31 Mar 2022 09:35:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5H+Fbmj64jgA4ncr30/U89NJFBLsIepl24tNMDjagbBfEF4t4n1r4kQNtzs/iHaZS3ljt/RKNup7va6Els44PtzFr0eikWHzN9Yv/YrHvBg4BopTacpLvTw+QwHIOniXAA5UHvoN2icdi+M2VPOxlEc6XvAZdgQS7fwRhgdqyNfffysshFK2AsKgGxIUqY2fnQCk8csIB30zLfc982OJJdG0R1anXrk78EUnXewDoeRA4d8EYFYJp5/HTiXNDtq36ouoIpprte5FD3+YzcR5kb0sWTMwnoyGlRhA/3Cs2Pl4maOQyoAcYe7c8FtDBFvH1eTzLActTJu/vR0B7SYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBxHH8MQnCkKIFdBhjubloKhFkLXpAsnf33giRfzEqI=;
 b=OFnUUESFw7dAdcRGAdMLigTyz56IXVfcULvaTsccH81naynBk7mioRzgIOCuIzWpF38e9BeOFxLPH1tTEjR7CTnPBgnFjEvU2WqXnxCs/U3yHyG/jVgqT7Gxu7BcdtnujK3gTINTeI2OYhBj/dpmuxECyFPAQ5KafkFrNm5IIO0S25rEwQcbyUI9BYF2CMRPcbNxfRHJBNT/+ZxKDiPwolI7+pVk3ObSV/OAUf1Dw45hnsxD83Zwg5Eew3m5Ad017GMN8T4ZXLPuYC8O5QUSYz7ipHrXoOJW8/oqGQnKeUpMqKbLMZeP0FAt8URvbXWGkjoaAOfyMo3SL/depTclLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBxHH8MQnCkKIFdBhjubloKhFkLXpAsnf33giRfzEqI=;
 b=BtmGl1ZpZEHyjFhQU4zYvL7XdrS1cJtwIOsncf7IuABzjXDCXZqFScxwUqDU3yyy0a3vgHOenZV+fO9zoN3KXhc/3+a0AjimlI/WeyjpbCRfoE9S0ar7q/Veic82MKZwVHXxeagu3t0V5OdrwfL5CuKtoCHEnslr0Dru82oIsmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by BN8PR12MB2993.namprd12.prod.outlook.com (2603:10b6:408:63::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 16:35:40 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::981c:a9e4:48c:e82f]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::981c:a9e4:48c:e82f%6]) with mapi id 15.20.5102.022; Thu, 31 Mar 2022
 16:35:40 +0000
Message-ID: <f7bf22a5-3162-352d-386a-5c9a567e0893@amd.com>
Date:   Thu, 31 Mar 2022 11:35:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/2] x86/mce: Grade new machine errors for AMD MCEs and
 include messages for panic cases
Content-Language: en-US
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bilbao@vt.edu
References: <20220331163211.5994-1-carlos.bilbao@amd.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20220331163211.5994-1-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0030.namprd22.prod.outlook.com
 (2603:10b6:208:238::35) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 157b961f-a8af-4546-a0f1-08da13347e10
X-MS-TrafficTypeDiagnostic: BN8PR12MB2993:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2993B088B09822554BB417EBF8E19@BN8PR12MB2993.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jS3wU2sq5wlUE99q17S1gjS6mmT9qWVTa4VtDKVFsdnthFPrbA2YYwZbpHzFJl4aRQjx589YIKIHHIrwiDmI1W30sDAgEthjsj18sk5ceBRuVvyldqpT6smClHdQsdHCHWysDkwmcLucsvL73jbYRGSpoeZNPWLMlkxR/z8qhJo/EfJa3nvTbOvR0VDIyo22ECkG8rVblPoeAxzVFLl8okVWYVxPgzzacYyrHuV/WDea/yyUgfyIXa8/Ehmh+OnrOlfW6nXrNlBtNhgb/fXqtL/fFWSmrrIvSaDnGNNZJ7VQAwMX/KOq0r8eYWwVNYeO+/bNTF3WIz+p7W3Wt1d8sjCx6QJ+e+ehO3jHW+Ekg+esvwLUgdH0Nkz3sLk8ZneN7s9Yj4ounXcpVV2hScjDK4+bHt+0Id+Y7KjCZwSpoVguryHLQfOkXG+nnn8DX0NVI2KEFOHly8R0Ypyy9go6HMR6woFApXDa3EuLBk3rWBS+LMZnWGd4cyvOKCMbLkxrXmoqUARiI2v+Y9OHz51FkzIrmmrrUVAMLZ4kEwvHEAylD0pqeiRvv4nhVPawQrWNEOTYtjT+/J1HZJs8xQBDI513WE8ELCVjfBY9Vcst8Uq6st7wu23/XSQXysjOV8bY9bzfEQfxo6HuW0j1A1dy2bNZT2Do/rAb6Nl7C0dWekXepdTqkEN+UmcvyLd+8gqNJB3tiiHZxk26x0Ka1s4J3xVE58Gfxx3CVQm0ZCZVGaOIhVJmb2mrHcUi6JK8wVy1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(508600001)(15650500001)(6916009)(316002)(6486002)(2906002)(8676002)(66476007)(31686004)(26005)(53546011)(6506007)(36756003)(186003)(5660300002)(6512007)(8936002)(86362001)(4326008)(38100700002)(44832011)(31696002)(83380400001)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzdGR3pwelhxVEdYREZwbFFYL09FU2F1ZUJSS2h1d2ZZR2oxYkxLL2VCZlZs?=
 =?utf-8?B?Yk16Q1RpL1kxWVJvSlVvS1EzZUdmMEJrL1ZGRWlTQzVvNjVpZjFOR3dnYjY1?=
 =?utf-8?B?Tll1QzNsMkNrL3lnMTJqUDJUQWhHSjBSeFpEYWRxR2h1ZGlBcG9kTXhIWktC?=
 =?utf-8?B?dTZ0VUozUnkzdzJsTDk3aHpoYml0YWRkVWRpaGVIRkZ6dS81cUljYkU0ODU1?=
 =?utf-8?B?cnY1Z3hBZUxYZ3pvQWtMd0wzWG1VakR2Ni9WdlpjTWdsMjhrMnVndUhaY1Rj?=
 =?utf-8?B?U3ZiSUVLTjNKelhoN1Nka1JhRDk1QlYwbk05SnpLeFFKNFJvSFpNNnBXMzlT?=
 =?utf-8?B?VlNNdk1zZkNoVlExVUFNT0h4QlJ2UjQwc1dxSGxESkp1aHdJVEpXY3FGakJQ?=
 =?utf-8?B?clg3bTVscGE0UlRvaC9hYmRSMmhVSTU2RnprdmdEeVBnQ3VLbUVXeE9VR0Vx?=
 =?utf-8?B?aXpSZFhYWWhXNFZ5LzlnN1FNOE9jZmhzaS92ODFwcnVXdUxEVDRxbTZIOWky?=
 =?utf-8?B?dExTYnltYkQ3b0gxRTQ5NXl1RkxSUXB1dCttZGFhMnQzSVZadDlZc04rUm52?=
 =?utf-8?B?WG5TS0ZvV0lCYm1IRkJlcFJSZ2FaaFVaTkcvbEl4aUpqbncwRThlNEt4YTRv?=
 =?utf-8?B?UFg5SDBHRnU4RW5uU3Rjd2oxNGFnTkNNdHRtaUtBcmJMaGJtVk1YRGgwUEZz?=
 =?utf-8?B?b0U1d0h6Nk9XdFZlZFo4dmFFSE5oaTBSRFpsZzNuYVRtWHFTS2VCQkU5SXZ1?=
 =?utf-8?B?eUt3RGNwRFVwejFoaU5NZVY0WmVURU92TzF6Vk1LU3ErY1hTc3ZLcE9NNXQ4?=
 =?utf-8?B?LzBLWG1pM2puYUZ5SXBNbE14bWFsYU44a0N0VzNMaERCazVBMDVNTm15ZW9m?=
 =?utf-8?B?RzBVb2ZnQTl6UTZQbjlzMGJFQS9mT1BJQ2hTMk5lNG15WkNRTXZlOVl1amZu?=
 =?utf-8?B?WC9hSlJvYjdBeW5NRWlKdEVZaEp5QUJ1d3FVUG1aTktsM1h2cGZJZGVET2JO?=
 =?utf-8?B?YmYrUlNLV1dFSGI4ajFqK0Y1ajhwdDhQc0ExYkV0NTMwYjFDa1RNUzR6QkNO?=
 =?utf-8?B?REpXY3A2YTl0OW9vbGcwUTFtOUVNL0FXWGp1MzREem9GWERoRGRQclZhbFJr?=
 =?utf-8?B?dDRIeG4vcEhzcE1IUmlaU0ZHTXNPb2lNa2ZIcFE5SjFVanZWcndtbE1FTXRO?=
 =?utf-8?B?UTcxRnJqN1g4d0F5OWJER0lFVGJWSE5CalVoUWpCTGpmWEthOUhZeXNScUJ3?=
 =?utf-8?B?Zml4VXhrbTRWS2t3dE1BMVZaWUJtZUVibDJlbVV4RVlBMm9GeUhwdDRCOVdu?=
 =?utf-8?B?bzJRVFFGTkFoTFkrYVF5OVo4UEhqaW5JNDlXWlR4L0RCWnE0RkpFa01GaFU1?=
 =?utf-8?B?RzY1YzNCRFhmY21XcW1lK0JQSlF5QnJqUHJKS3hTd1kvUVlnWkZndTlpeGtT?=
 =?utf-8?B?U1dmTTk1OGJLWGpHeW1ub2xIa1BKY1VHM3RsMDRCYmRYUUxyNWhXVzA1S1RI?=
 =?utf-8?B?S1ZYeVJMck5uZSs0ZVBaTFFFczR3bHFCQ282TzJGWXhISzJqNlQyZnNUMUM3?=
 =?utf-8?B?aEVjbmF1VzBZamFKS25MZ2dDRXA4b255WDlpT2dDeVVtbi9kUmpRQlVXbTNz?=
 =?utf-8?B?VmNZQXB6MXUrME8zN0VQV3RYeUhKQkJXTmEvQmQ2SWpaZk1JdTd1Y3hXSHVZ?=
 =?utf-8?B?VmtqR3ZOMFg0SkZuZFBjNEtZOFc4bHFBb2dFcVFVWkJOdzc1L2Q2bzA2REdI?=
 =?utf-8?B?Uk0rNHJxQlpKcEtqU2V0Q01CQlQ3dU1Ha0l0Tjd3S2dUVmZyV1NTQnpSZ21k?=
 =?utf-8?B?U0RhdWphbDJHTXpSNzJ2KytnVHZPNzBFWkQya1RMa3ZITHZSZHhqR0xMbHZG?=
 =?utf-8?B?QjBsSWRLOHJIK0xyVlRXdXg2Ylk2aG1wWmJEUnJhN0xleVQ0OFMwZFNZVEw2?=
 =?utf-8?B?MjRrUm9wd3MwQWxjWnBTK0JJZlpWcS95SFMyRytXemdsLzBBTmFnS1lINVYr?=
 =?utf-8?B?QkNuR0NSb1FrdEhWaUNQT1JhcXAvREMyRnpxZWoxR0lUMGtXcGdVWWJFaCtj?=
 =?utf-8?B?RFBHcWYvTjAzZDZRUzdNL21RU2VOMlp1aUw4Zjd3aHhkYUhjSEp3Sy9uTVBH?=
 =?utf-8?B?Nmk5cW42dThOMGI3SDRGQklqVExKNTlKZ2lUYVI5a2NGZ2c4Ym1yZ21JN2xo?=
 =?utf-8?B?VHdmcEhWbFJNam1tOWIvb0pySTFGNVQ2a0xBaXBFVHcyNFBTTTUvOWcwdWdC?=
 =?utf-8?B?Rm9LRVlESlFuVmtINjhvbnNxWitEeVdJSGNOdXFEK1FLOEhtQi9ndHRDdlZS?=
 =?utf-8?B?Qm1wYm5mZXhtcC9DYWxrVVV5cmcxOG9Mc2lxejduMDdCZFp1WSs4Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157b961f-a8af-4546-a0f1-08da13347e10
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 16:35:40.2311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xq88EcjhGuziQF+R14w+aCOpTS/AwxjGrQqhB2PK/zTjgbsMR0tk3KlcNd9TQ3k2y+aOGGdkyBnXck0uEdabxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2993
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 3/31/2022 11:32 AM, Carlos Bilbao wrote:
> This patchset includes grading of new types of machine errors on AMD's MCE
> grading logic mce_severity_amd(), which helps the MCE handler determine
> what actions to take. If the error is graded as a PANIC, the EDAC driver
> will not decode; so we also include new error messages to describe the MCE
> and help debugging critical errors.
> 
> Changes since v1:
>   On patch 1/2, follow a simplified approach for severity.c, that resembles
>   the available PPR more closely. This also simplifies patch 2/2, as less 
>   panic error messages are added.
> 
> Carlos Bilbao (2):
>   x86/mce: Extend AMD severity grading function with new types of errors
>   x86/mce: Add messages to describe panic machine errors on AMD's MCEs grading
>  

Oops...

>  arch/x86/include/asm/mce.h         |   6 +
>  arch/x86/kernel/cpu/mce/severity.c | 203 ++++++++++++++++++++++++-----
>  2 files changed, 174 insertions(+), 35 deletions(-)

I forgot to update this, my apologies! resending...

> 

Thanks,
Carlos
