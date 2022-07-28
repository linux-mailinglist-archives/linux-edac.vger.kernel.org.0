Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E105845E8
	for <lists+linux-edac@lfdr.de>; Thu, 28 Jul 2022 20:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiG1Scb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Jul 2022 14:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiG1Sc3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 28 Jul 2022 14:32:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C779A6D9D8;
        Thu, 28 Jul 2022 11:32:28 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SGxXwf015372;
        Thu, 28 Jul 2022 18:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=R/dpcmNG1j6EIjcQIqDXSgDO3GjLGVdXGFNv/OENuxI=;
 b=POCw+T65D79+WGRmf8dl7fu2DrhxDfeuKjzf7TpcT/fDle1En2Ka+wWV03UBk7jZCWfR
 QTZFV1ehCfZr4X9b3oXNu4WRdqdRX0oug+7Cy7uamQOTsyqPpvbU0i2kieUPyYEhl4Qi
 /o6gsQeryWZ9jyIaqyrqjOzGx9i5qN6/OIO6l5Xc4YkvHvU0nL+aPb1g9e8FnWDpF1Fm
 bGNjdBiZkSxF9U3SBhV3voPDnNURUom79pvji3jDD3NkGHzMETSd+4z/eWtUsYbzaOV6
 zdc1uBABU9v8QsBHfoW5xw3AoWI59Oin5ryt5dO+wKSf+cXI43Ic4W/lREd7qtCIqz3T XQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg94gnca3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 18:31:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26SI1ZEc019901;
        Thu, 28 Jul 2022 18:31:48 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh63awa2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 18:31:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJDv5hBBWGQknFM4VPhokBbAB78FDvH0o0Zrcp5wud3w2Qeqaa9j1W+iH6solCQp8EowkrKg11+AW8oux+Dn425DUMYDZilAY1UzQ7V+GgW1fPEx/ITvTYarCIbE2Jr7gpDtuyn2XPn7NG8CUpj4k0k03p0+2RDhf1CqYWnTT59WkVPs5AKiTU4FsQsWsgCPZ+v+zSl1w/igf/s1taL37nZTh3cBOdjnLlMNdbstwESOXHkH0VU0XnVU3zUjKGp+aVHM/8VKK3uONoUO0Ou2Fesh6RfJZCbBTXXYcUXFczhuJryqdEa2gISesO9GdqxzX2lv+pMAnX1vx1SY3VMZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/dpcmNG1j6EIjcQIqDXSgDO3GjLGVdXGFNv/OENuxI=;
 b=Yw3vGR85xHaQ1vUQp8Eu4W6A1GFmakJ9qDvvLLEtJ5S6CeRPSsCR1tJOAM+8lEfPB0RbJ0mdWRzoEoN2TTBgPCQ2KJx2XWffWb2H7Tj/6v/udU54WaDTKNNCN0FbYAnsVpJJeA5efWkWQy+EZZYuWWkweamlRJIwckiztlwDa+lvagQuq9t+FDjM7BTwtKP8yIFJ6IxV1jNY3SS6N58qCpzZM60zFqfB0tCiwDyE/t316CqYZoXhVBseiv2476ggqQTl9hlShF6/nYoq5IPEpoHai8vViUiFf6koJSOc7nw3Ip624DjhK8fjTXSDWTwoq8s6b7wNnD0wC5IFpg5S1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/dpcmNG1j6EIjcQIqDXSgDO3GjLGVdXGFNv/OENuxI=;
 b=o4p0zZRa7g8ef8cxg5+E5vc8rmszudCZdsNdwEroSQ/xLZXe/gLAxY+0TFdGtdvmFVmO+NvW0a0jSNRX3KnpK6ywQNoYUW5iHvAiuWL5rUfw0h2FYKXzNsXZVlysGzQL0mRG7A14YIv6ZT4fgtinYHO/AqSBr6x5W5UAlOBkdTU=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2951.namprd10.prod.outlook.com (2603:10b6:a03:84::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 18:31:41 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112%9]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 18:31:41 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v4] x86/mce: retrieve poison range from hardware
Thread-Topic: [PATCH v4] x86/mce: retrieve poison range from hardware
Thread-Index: AQHYoek9ERW6GrarlEiLoaZlsaluTK2SkWMAgAAHxACAAAGfAIAAAU2AgAAHboCAAXk6AA==
Date:   Thu, 28 Jul 2022 18:31:40 +0000
Message-ID: <9ca37489-e7f6-f619-c9a7-a1d9665c477f@oracle.com>
References: <20220727184644.2685405-1-jane.chu@oracle.com>
 <62e18a687aac2_2d20792944b@dwillia2-xfh.jf.intel.com.notmuch>
 <f22faecf-b4ea-cb39-bed3-3647842b814e@oracle.com>
 <382e9410-d964-5600-4481-ccad90dbc97b@oracle.com>
 <8e817134-bfa9-72bc-3601-eeb1a138fe37@oracle.com>
 <62e1999b4121e_2d2079294ea@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <62e1999b4121e_2d2079294ea@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6af60cda-2f18-4ef1-936f-08da70c76a43
x-ms-traffictypediagnostic: BYAPR10MB2951:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lx+lnP1BMS14T79fto6IgP40p4OgpNAxJrrtttvK4HBXioQZpLc+2Z1j2fh+altPT8cz2a4IHsB+RRpplOrZiyc2QRjLHE2N9ZjR/Lnjh5SWnhHKRmeFcvT8rcG8vkei1VdmdYqa48neessZTm+RSupKkD1wnRlwNgvIR+nuHtp3vnfj6Sh6WCk9mCfW90efJNNYYsvg5cqQgsEzqmpkcgWgE1zNLvWca2C1UAD0H7d3huJ/JxHJ8yURCu+WlUKq5r1mMYiMUIj7SA719zEyxChuW3/cnlne+5gA1Q3ixt9TpFgaRDZf9QxW2yfPjOrCXxW89ixxi8kUfb0o5E5/qm73q7hKXNiBJZrUc+ACvoP4C7Y/2SsAAnsd1i2QVDoaQhb3t//DW5AdbPYAUphaX2zLebPNeSKTAaH8tpmC1/rIdKAnQnSx9uOEfwk2tZcAYVpmye387Y9nVzZIFkjfVFHpc3CJh/v+aiKbwZ5+QFbAyxNe/bEIXAoPkCPsfvBAj3siLbMndpsrni5pV4BHBzL/Z13uDFOQEqMegcZniJ6O2RX9joCsMwGn9qKevRxH0CojSpVxLohG0x/KBW+aXU1C4HJMQKuDpp5nutWhpK/wuyEC/qZ5oN+fj8RKhuQ/qeT6Yff0UNjaOQi1TDThL0qg6oueRbn3f7qgLYzu35kZiTB79iIlA5d2Iv52X2+eSLcxp/yqtinOjtv9lT12hy5Bvc6OVQ7fNUqyMmgr214bAymF0i/Iz6wf20Z5XgwpPbAL8z2t5slKAwZWV0ni3Wz0cudgf4OXH4mY0oyM3YRoF0zMlJ4qbZUKWdjk5BbbINWnKcJBdvEsfMmMKZ3/LT+6Ok9SFzehqpcvD5TE3bHKFmcBg85QWm3mjH+PzVI0ArBGo8t2XLuLpENh3odkcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(366004)(136003)(396003)(6486002)(36756003)(478600001)(71200400001)(110136005)(966005)(6512007)(26005)(316002)(31686004)(83380400001)(2616005)(76116006)(66946007)(91956017)(186003)(66556008)(8676002)(64756008)(66446008)(86362001)(921005)(2906002)(31696002)(38100700002)(7416002)(66476007)(53546011)(8936002)(41300700001)(6506007)(38070700005)(122000001)(5660300002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnU1R0U2b3FuMkZ0dVFETExvUm4zWFluSTJOWVZ0aVJTVjFEaTk1KzRySi9v?=
 =?utf-8?B?ZUJybzVUSE55SGlVZERSVVpIUXlaSDlvWno3emhXWHIwcE9MQzFBZTJCdGxq?=
 =?utf-8?B?TVduVGV0ZHFPUEttbmZ6Z3hoQ0xTR2xERG9ISlYvanl2TitwSERKSkFjSmZy?=
 =?utf-8?B?eFBQMGR5aDdNWDVOVTRWZ1pweUd1V2cyZlR6R3VqZFNsd1dPc3JoWjNYUUxK?=
 =?utf-8?B?NHNMM2FnSVlCd21BclBua2drK0kyejU0NGdmcStXVUxUaWpIVnRZMTV5aGhq?=
 =?utf-8?B?bGVZWHB0bzhCYWsrNjBTc2JYTnQ5WFhURzdTenlMODFNeldMZlJTL1dMbnY1?=
 =?utf-8?B?L0tIbnpYNVJQSXd1S0VDYUhXc2xmWUl1a3dCeHZTTTNsUm1KZHhiTHAxczJt?=
 =?utf-8?B?bzJSanI2OHVCVlVEY1l4aS9CUWljTEJIQktQRVJwZmQzZERlZmZyMU1GQmxD?=
 =?utf-8?B?VGg2akxyM0wwMzJrL1JVelFYZzRTL1pzOU81Mk1LRUtnbVNML1RBcUFMU3g2?=
 =?utf-8?B?Qlh6bSt6MnA2cHZkanhQbmg5OE15NzdSRUlWK3lJYlA4RXl0eXdHaHJ4Nk5D?=
 =?utf-8?B?Wm5JWUlyWURVVkVQNUl6M0lIWVNFQ2FNMURUcldEM21CYjN2ZlJhbW5EVXk3?=
 =?utf-8?B?N3UyS3pMSzZzZWVqYTdJNGhXYVJMeUoyOGlRVWZDRjlMKzk4dFU3SFVqdHZs?=
 =?utf-8?B?SFd2bHp3UUFTTVN3U3d2OEEzSGdyV01RM3YydG8rZDFjV0VqSDhtc3h0UThX?=
 =?utf-8?B?c2xyZS9NVm1VbjBDVmVaT21hL1A2cVVLSDRxc2VMY2NiLzdGb3B1RjdDdlZv?=
 =?utf-8?B?czlZTi9FQzRWNzVRMTdPclBXTFEzbk9EcHA5cWN3TlFVTjlEMjg5a1F0VVQy?=
 =?utf-8?B?RzJVdDBlNnJaTjdvK3RLcVExclVvd1ZPaXlqMUVUZW9nRHowbWlhaTZ6R1A0?=
 =?utf-8?B?aGZyZWxFZDB6VTJLS2dkNFd1Y3N6UERJV1BzMTVmSWJqcjdGcEU1WlVOUDRK?=
 =?utf-8?B?Zy81R1Q5RVprSjIrUjBac1FBSnNmRlQ1dWk0VStIVXdYVXZFZGg0TEllUTBy?=
 =?utf-8?B?NDMvMlBCZEdXZ2w1WGg3cVlqZzh2aWhsaDA4d05VUXhpTFdQRnhHdkpMWnNL?=
 =?utf-8?B?VjMwT0dzOVNqWCtMcGpFK3NqUi9HbW9md295TnBiaWk2SHpNYkhMeWRod08w?=
 =?utf-8?B?TUoydFgxRHlUTERudkhoOWdDNnI3REw0SUc5NW52aUxCNno0Wk13WE10VVha?=
 =?utf-8?B?ZDhCQU5wb3lqajlxWElXa3l6SndvejhZZHR1dDBzaWF0SUtyd0IvREZGemJv?=
 =?utf-8?B?bm5tVHV1aGRXY0dYRXdRbDZiUjVSVEZOQW42MFVHK1Q1SEpEYVdTanNGRG9Q?=
 =?utf-8?B?bE9tSXdqMk55L2ZQVktKQnFIWjR0MDNFZEFtekxCYXNMc3d2dWsvWnVhRnN0?=
 =?utf-8?B?elB3T0lhZ3lHeUFIbTRndE04aFJ3MWZWbEJvbG9WYXljQzVWcjZZS1ZncVdZ?=
 =?utf-8?B?Q2dWR0laYnFvUEFpYkJtZzZaaUxFTmt5cHBaZ2JsVzl5anlIOEQyU1M0TWcv?=
 =?utf-8?B?QWo4VEFZckd5MmxwWW15WUUxS0RqR0tFYk1Ia014THdtOE1OUytKTGFjTU82?=
 =?utf-8?B?d081aGMwVVozVGxsSVpJb1hyTUN4VVpzTk9wZ3JoaFFkOUVPOE92ZzAyM0h2?=
 =?utf-8?B?T25XQnVCQkQ5WE5YR0UwcVRXbmNEcSt0T0pvRTV5bkZsMHE5MjVvckovL3Rq?=
 =?utf-8?B?TDVOcFJUb2p5Q0lYRnhoQms3L2Evazg5b0E0aEVjeXRRdCtmMm5FUmhPSDB2?=
 =?utf-8?B?SFl3QTFtK0VOeE9vYzdnTGErWWo1c2NhcEV6a1ZQKzhDUmY5Rkt6YUduWGlW?=
 =?utf-8?B?OWVtNWo1WXpGaHRpdU81cFU0SndCN1RVcE9pQVNTanR1ZUE1QUZ6czZyVDAr?=
 =?utf-8?B?SEZVQ3VrVS9uWGxuUFdycyt3aHZwTEJhSDFqWjZzOGovUGlVckI2UHUxeFFz?=
 =?utf-8?B?SGw2ajRUV3AvU3V3UTg5YytwcEptVHJlb3JsLzIzdVEzRWNvenFOeUJ5bW02?=
 =?utf-8?B?U3ROVkN4VkV1WHJ4bjAyUXh4cVJkNVRKcSs3WHQyWm0zb29lRVVkNE5TVjhY?=
 =?utf-8?Q?vk8U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12C0A1BDB140D84E832D15324AD05BD8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af60cda-2f18-4ef1-936f-08da70c76a43
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 18:31:40.9806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gg3Drt5aSjZGYb76papuqv+bhWSIZzWaXVZ5eEj1TlM9kXM2VZGBxDEGmSpQg36NVENOAyZuNPxMhpJuG4eVNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280085
X-Proofpoint-GUID: KP67DbTICmyQ7_3dsgNs1IMkA5l_JmW7
X-Proofpoint-ORIG-GUID: KP67DbTICmyQ7_3dsgNs1IMkA5l_JmW7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gNy8yNy8yMDIyIDE6MDEgUE0sIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gSmFuZSBDaHUgd3Jv
dGU6DQo+PiBPbiA3LzI3LzIwMjIgMTI6MzAgUE0sIEphbmUgQ2h1IHdyb3RlOg0KPj4+IE9uIDcv
MjcvMjAyMiAxMjoyNCBQTSwgSmFuZSBDaHUgd3JvdGU6DQo+Pj4+IE9uIDcvMjcvMjAyMiAxMTo1
NiBBTSwgRGFuIFdpbGxpYW1zIHdyb3RlOg0KPj4+Pj4gSmFuZSBDaHUgd3JvdGU6DQo+Pj4+Pj4g
V2l0aCBDb21taXQgNzkxN2Y5Y2RiNTAzICgiYWNwaS9uZml0OiByZWx5IG9uIG1jZS0+bWlzYyB0
byBkZXRlcm1pbmUNCj4+Pj4+PiBwb2lzb24gZ3JhbnVsYXJpdHkiKSB0aGF0IGNoYW5nZWQgbmZp
dF9oYW5kbGVfbWNlKCkgY2FsbGJhY2sgdG8gcmVwb3J0DQo+Pj4+Pj4gYmFkcmFuZ2UgYWNjb3Jk
aW5nIHRvIDFVTEwgPDwgTUNJX01JU0NfQUREUl9MU0IobWNlLT5taXNjKSwgaXQncyBiZWVuDQo+
Pj4+Pj4gZGlzY292ZXJlZCB0aGF0IHRoZSBtY2UtPm1pc2MgTFNCIGZpZWxkIGlzIDB4MTAwMCBi
eXRlcywgaGVuY2UNCj4+Pj4+PiBpbmplY3RpbmcNCj4+Pj4+PiAyIGJhY2stdG8tYmFjayBwb2lz
b25zIGFuZCB0aGUgZHJpdmVyIGVuZHMgdXAgbG9nZ2luZyA4IGJhZGJsb2NrcywNCj4+Pj4+PiBi
ZWNhdXNlIDB4MTAwMCBieXRlcyBpcyA4IDUxMi1ieXRlLg0KPj4+Pj4+DQo+Pj4+Pj4gRGFuIFdp
bGxpYW1zIG5vdGljZWQgdGhhdCBhcGVpX21jZV9yZXBvcnRfbWVtX2Vycm9yKCkgaGFyZGNvZGUN
Cj4+Pj4+PiB0aGUgTFNCIGZpZWxkIHRvIFBBR0VfU0hJRlQgaW5zdGVhZCBvZiBjb25zdWx0aW5n
IHRoZSBpbnB1dA0KPj4+Pj4+IHN0cnVjdCBjcGVyX3NlY19tZW1fZXJyIHJlY29yZC7CoCBTbyBj
aGFuZ2UgdG8gcmVseSBvbiBoYXJkd2FyZSB3aGVuZXZlcg0KPj4+Pj4+IHN1cHBvcnQgaXMgYXZh
aWxhYmxlLg0KPj4+Pj4+DQo+Pj4+Pj4gTGluazoNCj4+Pj4+PiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9yLzdlZDUwZmQ4LTUyMWUtY2FkZS03N2IxLTczOGI4YmZiODUwMkBvcmFjbGUuY29tDQo+
Pj4+Pj4NCj4+Pj4+Pg0KPj4+Pj4+IFJldmlld2VkLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndp
bGxpYW1zQGludGVsLmNvbT4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKYW5lIENodSA8amFuZS5j
aHVAb3JhY2xlLmNvbT4NCj4+Pj4+PiAtLS0NCj4+Pj4+PiAgwqAgYXJjaC94ODYva2VybmVsL2Nw
dS9tY2UvYXBlaS5jIHwgMTQgKysrKysrKysrKysrKy0NCj4+Pj4+PiAgwqAgMSBmaWxlIGNoYW5n
ZWQsIDEzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pj4+Pg0KPj4+Pj4+IGRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9hcGVpLmMNCj4+Pj4+PiBiL2FyY2gveDg2
L2tlcm5lbC9jcHUvbWNlL2FwZWkuYw0KPj4+Pj4+IGluZGV4IDcxNzE5MjkxNWYyOC4uMjZkNjM4
MThiMmRlIDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FwZWku
Yw0KPj4+Pj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FwZWkuYw0KPj4+Pj4+IEBA
IC0yOSwxNSArMjksMjcgQEANCj4+Pj4+PiAgwqAgdm9pZCBhcGVpX21jZV9yZXBvcnRfbWVtX2Vy
cm9yKGludCBzZXZlcml0eSwgc3RydWN0DQo+Pj4+Pj4gY3Blcl9zZWNfbWVtX2VyciAqbWVtX2Vy
cikNCj4+Pj4+PiAgwqAgew0KPj4+Pj4+ICDCoMKgwqDCoMKgIHN0cnVjdCBtY2UgbTsNCj4+Pj4+
PiArwqDCoMKgIGludCBncmFpbiA9IFBBR0VfU0hJRlQ7DQo+Pj4+Pj4gIMKgwqDCoMKgwqAgaWYg
KCEobWVtX2Vyci0+dmFsaWRhdGlvbl9iaXRzICYgQ1BFUl9NRU1fVkFMSURfUEEpKQ0KPj4+Pj4+
ICDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPj4+Pj4+ICvCoMKgwqAgLyoNCj4+Pj4+PiAr
wqDCoMKgwqAgKiBFdmVuIGlmIHRoZSAtPnZhbGlkYXRpb25fYml0cyBhcmUgc2V0IGZvciBhZGRy
ZXNzIG1hc2ssDQo+Pj4+Pj4gK8KgwqDCoMKgICogdG8gYmUgZXh0cmEgc2FmZSwgY2hlY2sgYW5k
IHJlamVjdCBhbiBlcnJvciByYWRpdXMgJzAnLA0KPj4+Pj4+ICvCoMKgwqDCoCAqIGFuZCBmYWxs
YmFjayB0byB0aGUgZGVmYXVsdCBwYWdlIHNpemUuDQo+Pj4+Pj4gK8KgwqDCoMKgICovDQo+Pj4+
Pj4gK8KgwqDCoCBpZiAobWVtX2Vyci0+dmFsaWRhdGlvbl9iaXRzICYgQ1BFUl9NRU1fVkFMSURf
UEFfTUFTSykgew0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBncmFpbiA9IH5tZW1fZXJyLT5waHlz
aWNhbF9hZGRyX21hc2sgKyAxOw0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoZ3JhaW4gPT0g
MSkNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBncmFpbiA9IFBBR0VfU0hJRlQ7DQo+
Pj4+Pg0KPj4+Pj4gV2FpdCwgaWYgQGdyYWluIGlzIHRoZSBudW1iZXIgb2YgYml0cyB0byBtYXNr
IG9mZiB0aGUgYWRkcmVzcywgc2hvdWxkbid0DQo+Pj4+PiB0aGlzIGJlIHNvbWV0aGluZyBsaWtl
Og0KPj4+Pj4NCj4+Pj4+ICDCoMKgwqDCoCBncmFpbiA9IG1pbl9ub3RfemVybyhQQUdFX1NISUZU
LA0KPj4+Pj4gaHdlaWdodDY0KH5tZW1fZXJyLT5waHlzaWNhbF9hZGRyX21hc2spKTsNCj4+Pj4N
Cj4+Pj4gSSBzZWUuIEkgZ3Vlc3Mgd2hhdCB5b3UgbWVhbnQgaXMNCj4+Pj4gIMKgwqDCoCBncmFp
biA9IG1pbihQQUdFX1NISUZULCAoMSArDQo+Pj4+IGh3ZWlnaHQ2NCh+bWVtX2Vyci0+cGh5c2lj
YWxfYWRkcl9tYXNrKSkpOw0KPj4+DQo+Pj4gU29ycnksIHRha2UgdGhhdCBiYWNrLCBpdCB3b24n
dCB3b3JrIGVpdGhlci4NCj4+DQo+PiBUaGlzIHdpbGwgd29yaywNCj4+ICAgICBncmFpbiA9IG1p
bl9ub3RfemVybyhQQUdFX1NISUZUIC0gMSwNCj4+IGh3ZWlnaHQ2NCh+bWVtX2Vyci0+cGh5c2lj
YWxfYWRkcl9tYXNrKSk7DQo+PiAgICAgZ3JhaW4rKzsNCj4+IGJ1dCB0b28gc29waGlzdGljYXRl
ZD8gIEkgZ3Vlc3MgSSBwcmVmZXIgdGhlIHNpbXBsZSAiaWYiIGV4cHJlc3Npb24uDQo+IA0KPiBB
biAiaWYiIGlzIGZpbmUsIEkgd2FzIG1vcmUgcG9pbnRpbmcgb3V0IHRoYXQ6DQo+IA0KPiAgICAg
IGh3ZWlnaHQ2NCh+bWVtX2Vyci0+cGh5c2ljYWxfYWRkcl9tYXNrKSArIDENCj4gDQo+IC4uLmFu
ZDoNCj4gDQo+ICAgICAgfm1lbV9lcnItPnBoeXNpY2FsX2FkZHJfbWFzayArIDE7DQo+IA0KPiAu
Li5naXZlIGRpZmZlcmVudCByZXN1bHRzLg0KDQpUaGV5IGFyZSBkaWZmZXJlbnQgaW5kZWVkLiAg
aHdlaWdodDY0IHJldHVybnMgdGhlIGNvdW50IG9mIHNldCBiaXQgd2hpbGUNCn5tZW1fZXJyLT5w
aHlzaWNhbF9hZGRyX21hc2sgcmV0dXJucyBhIG5lZ2F0ZWQgdmFsdWUuDQoNCkFjY29yZGluZyB0
byB0aGUgZGVmaW5pdGlvbiBvZiAiUGh5c2ljYWwgQWRkcmVzcyBNYXNrIiAtDQoNCmh0dHBzOi8v
dWVmaS5vcmcvc2l0ZXMvZGVmYXVsdC9maWxlcy9yZXNvdXJjZXMvVUVGSV9TcGVjXzJfOV8yMDIx
XzAzXzE4LnBkZg0KDQpUYWJsZSBOLTMxIE1lbW9yeSBFcnJvciBSZWNvcmQNCg0KUGh5c2ljYWwg
QWRkcmVzcyBNYXNrIDI0IDggICBEZWZpbmVzIHRoZSB2YWxpZCBhZGRyZXNzIGJpdHMgaW4gdGhl
IA0KUGh5c2ljYWwgQWRkcmVzcyBmaWVsZC4gVGhlIG1hc2sgc3BlY2lmaWVzIHRoZSBncmFudWxh
cml0eSBvZiB0aGUgDQpwaHlzaWNhbCBhZGRyZXNzIHdoaWNoIGlzIGRlcGVuZGVudCBvbiB0aGUg
aHcvIGltcGxlbWVudGF0aW9uIGZhY3RvcnMgDQpzdWNoIGFzIGludGVybGVhdmluZy4NCg0KSXQg
YXBwZWFycyB0aGF0ICJQaHlzaWNhbCBBZGRyZXNzIE1hc2siIGlzIGRlZmluZWQgbW9yZSBsaWtl
IFBBR0VfTUFTSw0KcmF0aGVyIHRoYW4gaW4gYml0b3BzIGh3ZWlnaHQ2NCgpIG9mdGVyIHVzZWQg
dG8gY291bnQgdGhlIHNldCBiaXRzIGFzDQphbiBpbmRpY2F0aW9uIG9mIChlLmcuKSBob3cgbWFu
eSByZWdpc3RlcnMgYXJlIGluIHVzZS4NCg0KQW5zIHNpbWlsYXIgdG8gUEFHRV9NQVNLLCBhIHZh
bGlkICJQaHlzaWNhbCBBZGRyZXNzIE1hc2siIHNob3VsZA0KY29uc2lzdCBvZiBhIGNvbnRpZ3Vv
dXMgbG93IDAgYml0cywgbm90IDEncyBhbmQgMCdzIG1peGVkIHVwLg0KDQpTbyBmYXIsIGFzIGZh
ciBhcyBJIGNhbiBzZWUsIHRoZSB2NCBwYXRjaCBzdGlsbCBsb29rcyBjb3JyZWN0IHRvIG1lLg0K
UGxlYXNlIGxldCBtZSBrbm93IGlmIEknbSBtaXNzaW5nIGFueXRoaW5nLg0KDQp0aGFua3MhDQot
amFuZQ0KDQoNCg0KDQo=
