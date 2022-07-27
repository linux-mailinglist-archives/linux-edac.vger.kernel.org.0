Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417695833BC
	for <lists+linux-edac@lfdr.de>; Wed, 27 Jul 2022 21:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbiG0TgW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Jul 2022 15:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiG0TgV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 27 Jul 2022 15:36:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36524F18F;
        Wed, 27 Jul 2022 12:36:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RJObfD029878;
        Wed, 27 Jul 2022 19:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=zD0tNUfqj6CfAPi1qTEPCfmWi5x5F88bCc0bGtQuvbU=;
 b=RUN7Ud4SGidy5wrPp+OJgzAfhvXUyeYug3f4dZ2PSBuBbeQnRXzVxT4HLIczxht6GqmT
 Eu4wQ7hTW+pK2RqfbM9QYkB2MfLXK0i40wIQayX/EMR+LAB/RSjR9PvieeWXVTN7RZXi
 Omv6QnPzD47A+V5P9SFuw36Grlsgx0KvUru0XHpZJSQgJag/hbIhqBJALwkz91fdT4xq
 Gey4FRUj0lpsNr4btqeAXl3EcVwtBzuPgWpUrCC/nI4+NV+v9tl2Y9CDJOWdwX02kiMg
 SvMYjAawrkPWGu2w3UR5aaxeJ+6XTLyhBZLdvlp5VaDbkt0HIduOS1LFaePDWK5ZgAMO hg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hsu1wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 19:35:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26RHqQ7O031498;
        Wed, 27 Jul 2022 19:34:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh64tsqct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 19:34:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gR55FoNINl/KAzVp1CwlnHH3RTSMXa7z1vQe0yVM18STabqJ9ZLIglauLSuG0+ZCwkcxNyyp1OQsowlTOXb/oHZSa5qpzSKiuyIY9X7/Qx93oZIrbZKJf/WHv9Cic5wlHNQaitluHuws21Srr5SS+vX81yhCD7q/+PrtzJzQSfAXcytk16P5dzJCstRiN6SApNmRf+lsuo5U+aLdAPBjuig538FvRPwHPnnngpZfQO9/QFsaoydLSOFIrRo5kPCdsrxXdstfGcvLPeaO9I/da5V99+zvgYSHRO4nIbbV3LH8YTqzn1hUxb0DGvMeAqwAlgmZgWq9Og+keMOO3vqKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zD0tNUfqj6CfAPi1qTEPCfmWi5x5F88bCc0bGtQuvbU=;
 b=OAmXgGo4LYuORnpeQD5AJZhIdVq1G+/vDohHWLucmRtSYkHY9g8Vvc2VMb4/RWtCzraQsFUW+9qNX2EZVZvgaPF42krV3X+EYXZ2pvQRo64UX5eAI4XVYlJc7kmABroUjIoQWjPwsPWXuZzUKULkXywhzlQ2vrJOq4oSPALP8Ncj8KbEhCajCDlahIsvjARyDUcXsckis6VQ7ZX7sQEszQqzrdqrZ00KvDc5bskW5/zlkJHPi2NSd5XtfNtycDRXCqwQzrWaLD6xjp/a+oM21YcrVoAlkXiNHYq+USi2OQcPytOyXpT+/Z4FaRlxgzejmK7RcXdEYjhejlfEw1L5aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zD0tNUfqj6CfAPi1qTEPCfmWi5x5F88bCc0bGtQuvbU=;
 b=B+3oXoylRyOJvhG+KOEf6wXn4tlD3GTehkaKz5YwH1YXGW3hK8s3JizKMeH47+NzCehveJ54BERsVnBlvDrtKqUJu5VYjuX1tjcaW6tuKiAiEOOW5SOyvpIwPWo7kcTLBbIVR5CXDFlNJTf8teHhwW0UD1sO/8RxHKm7Od/V9OE=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB3576.namprd10.prod.outlook.com (2603:10b6:a03:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Wed, 27 Jul
 2022 19:34:56 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112%9]) with mapi id 15.20.5482.006; Wed, 27 Jul 2022
 19:34:55 +0000
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
Thread-Index: AQHYoek9ERW6GrarlEiLoaZlsaluTK2SkWMAgAAHxACAAAGfAIAAAU2A
Date:   Wed, 27 Jul 2022 19:34:55 +0000
Message-ID: <8e817134-bfa9-72bc-3601-eeb1a138fe37@oracle.com>
References: <20220727184644.2685405-1-jane.chu@oracle.com>
 <62e18a687aac2_2d20792944b@dwillia2-xfh.jf.intel.com.notmuch>
 <f22faecf-b4ea-cb39-bed3-3647842b814e@oracle.com>
 <382e9410-d964-5600-4481-ccad90dbc97b@oracle.com>
In-Reply-To: <382e9410-d964-5600-4481-ccad90dbc97b@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd2da3eb-e0eb-40c7-0f8a-08da700715b0
x-ms-traffictypediagnostic: BYAPR10MB3576:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tpmCbqKQUwFtFLHxxX9Bww659K8eqKwb1ZIwCFU8Ng4DY0TNF2kxxBVB50mKXY8r5aKB7D5eRHf0gdWBw46fG79pMUJ2NobeSNOQPvbzdcM74DdQapEJVTq5ZDMKGidojb0zOrJraI3auWnCxraMorO5x++ZyYrFYDM8pI+TukKgQ2gV8098NxKZ/iJVSz9UYmMjImh6eStbd24//rjwNWdDINukTJB4a6qpsst4Fgd2tMb5tVQNeUmLhWkhYh3wc7Q4VOslrLNrkoiEBTl5Gi9BM/np9haeztF4GJLcP85KTomogxBdws8UQYyGjTE7aAhbmDE8td5PZK0O1PvfeScencgFgjnNSEFeWu9XVel2sQh5TxglAPqSogbqLaj4plVaXnX97zRDRsfDnV4gFNIvkLB8Uqumrw1k0l5Tm9R/2oFJ9REQqvsrjFQThSKXJDSOt/m0nYmc5x5816Ae6NjBSAn0uVNnZvcPoFTVkp66p3w6vwyIB2TfbB6E0wtsczh0MOHOdNPLLM0B2N0mNupInPXIcGjUyUO0HNYkZii89mDQh86CmwG6qCwAHjH53IiHE/hjdzKX/su7pZBoBc6OxHSfLeYw4fZSvY+RlU0jURO7EgEHQ8hAf508Msd22McfH/4w2oYBrsah4PGMh7GaqD5fhp5VLbIm9rob/80z7tIzdON2Am9Yx1VhBiJTnOIdjqARJd4cnmvhBV3+FRUtoil5ZpOLxfKAbnuAXNKk5wBcPvFoIVMngWczPLo6wttjNLyYv4EiOUkiNkex4DJCZKGOyEcG+tSUMF5u5jfPf03c/lRxBpwTDtN8Ce2SeZ2933w+zPM6qRqpXMY7s7k0ntoMzZNAWTRCsIGA2rTFrzvHDpsxqAnPh9vps+dg1yD0otF82nTQkXxzUw9wIyU3nzB+w4aZcjrVuLsucg4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(346002)(39860400002)(376002)(36756003)(31686004)(7416002)(2906002)(5660300002)(8936002)(44832011)(110136005)(66446008)(8676002)(64756008)(66556008)(91956017)(66476007)(66946007)(76116006)(316002)(41300700001)(921005)(38070700005)(966005)(71200400001)(86362001)(478600001)(31696002)(53546011)(6512007)(6506007)(6486002)(26005)(186003)(83380400001)(38100700002)(122000001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUI0cmtNZGw2cThwRXgwZVk2dHluT1JGdGoxS3B6WXVNNndXdFFVUWo5RkJj?=
 =?utf-8?B?Tnp5WXBmY2VabmtlZGcvSXJ0QlNTRFY1VGR5djJ2dDdoWk9zbWlMQ01MSlB2?=
 =?utf-8?B?MVpkaC80V0piVnJMeFZPbHJ6Mk1NZG9qNHhXdDlVeFpISWttVElHM1p1UEJC?=
 =?utf-8?B?MjYrallKNFZiUjF0VHRVSVNXMUcxd2NrN0xUOWJhTUVDODJsb2VPOFZsbmR6?=
 =?utf-8?B?RHFzQ3k0aUNLVUVVZ1lick5haWtTSTdYTE5ZOU1rdkJOaUVVekk2dis1WDdV?=
 =?utf-8?B?ZkhUcjJ0OFBuVTFSd2plME5XbU8rL0xZTEdhRFNNVGFGMTFHbHhoOGNqbWlt?=
 =?utf-8?B?RTVGZGdoa1BTVUxXTDZJZ050d3Fvemc4MkM1SDMzWGI0aDJ3R3Z5cm9JMnhO?=
 =?utf-8?B?alI2bmtLZ2hteXZObFFySUtDa2lQemxrTnlBMXgyc0JZTHR2NEdlZjVBSEtv?=
 =?utf-8?B?VDFlM255dDVoRjJNTkJxbFNrb0p4U3Z1Qk5nRU9XRmtnaVJkVjlHNTVuMWJV?=
 =?utf-8?B?RFNyb21QdnVJR3c3RytmL0wzVytWOWNIV01lejlpaFNjb1d3S012N3Y0MDBq?=
 =?utf-8?B?Uyt1MDhWQWpPZ3hYTDgydm9DSm9BdE9EOVM2SG1VZnJXTkJiK0lodWg5ZWxy?=
 =?utf-8?B?V0MwYlNpeVlQYnlwYWFrWDRDTGhac25GSnQrNlZxaG1XOEV1eDdjTFNIeDlx?=
 =?utf-8?B?ZS96am95U1JqQm1mb3ZqSkdrU2lCZ3JSTXk2a1ZNaEMxMS9pSmRlYndjMDlw?=
 =?utf-8?B?czAyTDRHKzZ3S01CNkhQZk9iZUtBbjJiVStLKytGZWRvcElOUGlSTkNHZTkz?=
 =?utf-8?B?R3ZKaWJDSHkra3R1RitMRDhsbkVLT1JtdTdlKzY3NUgvNksvMFFjdGZSRXlL?=
 =?utf-8?B?ZGEyckYxdDdKUURFVllBWjRnRmVMK1c2d1ErNjhyeEFLWkQwRVJRckpoRkhI?=
 =?utf-8?B?a1pVd2haUGNMRHpnRjkyNGJJVi9EU0Z3alRldUUxeGcrUU4zZkFtY08rYkM3?=
 =?utf-8?B?MGc0VnJQSmxHODlLb2Q4VUcwSUZLT2V1dGhXekFaR3VsSFB6MzJFa3Z2M2VW?=
 =?utf-8?B?aU5qcDN0dnJKTGZqUFZrR2liTFRtMjZETW1JOGlOTjRSbEcweWlnTWhNZjdt?=
 =?utf-8?B?R1lHdVRlSUFZOXE2U0t6bnBRSmpRVFp0Z0UrdTJYNXp1RGxuTjNYUXNNMXNJ?=
 =?utf-8?B?dDltM3c4M0ZnNmVBekdhRVRPYzRNdUorNWpDOVhrTTVWamRMY3RRQ0haTFpC?=
 =?utf-8?B?Yi9Zd21mU0RIcE54OXpIYVp2c1p3bGF5M1ErMWlkckcyL2JaaythWWdRMzBw?=
 =?utf-8?B?ZExOMUUwblEyeUFBOGVoNTBuQ095TmpDWWhqeDFJbVl2cm4rNlBhNk9TUTVo?=
 =?utf-8?B?dFJkYlRMNzcwYzNDa0EzS1hmVGRBSk5RbXRNS3prT0NSb3BkVk5WQjBzbno0?=
 =?utf-8?B?RWFtdWt1UnkxRFRwcm42RmRqUXo0ajBWT1Vra2FudFN1LzlxendiZW5RNGdj?=
 =?utf-8?B?Y1dReWhIU0hMSjFpV3p6YmZnWFZJdUdFWFU2eUNQNnFIRDM2N1htRmp2bXVB?=
 =?utf-8?B?eUNlUXVSdGE4MUlzOFEzeTJNU2VyaXdwVktmT0gwazdUdUUvWTdxblRjRXJv?=
 =?utf-8?B?cVFndVVXeFQ4aVZodkNBT1dzNEJKT1RaQUN5Sjd4dVVJOHZZTlZsQ2lQNWtU?=
 =?utf-8?B?SXBtMEw1UkN2a3VTTTZ1Q2s2WFpsaTVQM1Vzb3RXeTNBVE11QkF6dlUxY3ZR?=
 =?utf-8?B?aVRmT0IwZzFKb3R2SDV4Y1UyaVFVTWNKS3J2NzA3bG1abXhYRzlTR2NFa2Uw?=
 =?utf-8?B?UHJtb2dJU3ZGcW1LTnowZ0IySWpSTHpneVF6T25tUW9HYUxtOUcxdW0yMHJr?=
 =?utf-8?B?aDgwcnN2R1B5OC9xWjJURTU5ZmFWenoyU3ViVExRTm1QeFhVSHdHS1FnNzFo?=
 =?utf-8?B?eWxmS2NwaGdpVncrV0tQSGxiaUVQMGN0bVpzNjZDV3FXSjJoaDVZQ2QydG5F?=
 =?utf-8?B?WDlkNWQrV1BOU2VyaTBnNmVZRzRuQkdNWXhnWFBYNTNDakt2QU5UeFlvYktr?=
 =?utf-8?B?bEhXL292SzRjQzE0YnRmeWlpOEV4YmhFRlFBNWEwNXNlOS9CUktmZElyMjFF?=
 =?utf-8?Q?4JMo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7F848A26001744A969CF70123AC2592@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2da3eb-e0eb-40c7-0f8a-08da700715b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 19:34:55.6819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +YACAiC5KcrTL0nYWV7hT3nqG2hC6Kj+kOvDm3Aybk9AnokqseivckJs+Wd4+r/bTBYFB2Ri4GrOrd6oEM0hMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3576
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_08,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207270084
X-Proofpoint-ORIG-GUID: vGi0mISSJQKjm3n-vIdxVpnoJbKVgZ3x
X-Proofpoint-GUID: vGi0mISSJQKjm3n-vIdxVpnoJbKVgZ3x
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gNy8yNy8yMDIyIDEyOjMwIFBNLCBKYW5lIENodSB3cm90ZToNCj4gT24gNy8yNy8yMDIyIDEy
OjI0IFBNLCBKYW5lIENodSB3cm90ZToNCj4+IE9uIDcvMjcvMjAyMiAxMTo1NiBBTSwgRGFuIFdp
bGxpYW1zIHdyb3RlOg0KPj4+IEphbmUgQ2h1IHdyb3RlOg0KPj4+PiBXaXRoIENvbW1pdCA3OTE3
ZjljZGI1MDMgKCJhY3BpL25maXQ6IHJlbHkgb24gbWNlLT5taXNjIHRvIGRldGVybWluZQ0KPj4+
PiBwb2lzb24gZ3JhbnVsYXJpdHkiKSB0aGF0IGNoYW5nZWQgbmZpdF9oYW5kbGVfbWNlKCkgY2Fs
bGJhY2sgdG8gcmVwb3J0DQo+Pj4+IGJhZHJhbmdlIGFjY29yZGluZyB0byAxVUxMIDw8IE1DSV9N
SVNDX0FERFJfTFNCKG1jZS0+bWlzYyksIGl0J3MgYmVlbg0KPj4+PiBkaXNjb3ZlcmVkIHRoYXQg
dGhlIG1jZS0+bWlzYyBMU0IgZmllbGQgaXMgMHgxMDAwIGJ5dGVzLCBoZW5jZSANCj4+Pj4gaW5q
ZWN0aW5nDQo+Pj4+IDIgYmFjay10by1iYWNrIHBvaXNvbnMgYW5kIHRoZSBkcml2ZXIgZW5kcyB1
cCBsb2dnaW5nIDggYmFkYmxvY2tzLA0KPj4+PiBiZWNhdXNlIDB4MTAwMCBieXRlcyBpcyA4IDUx
Mi1ieXRlLg0KPj4+Pg0KPj4+PiBEYW4gV2lsbGlhbXMgbm90aWNlZCB0aGF0IGFwZWlfbWNlX3Jl
cG9ydF9tZW1fZXJyb3IoKSBoYXJkY29kZQ0KPj4+PiB0aGUgTFNCIGZpZWxkIHRvIFBBR0VfU0hJ
RlQgaW5zdGVhZCBvZiBjb25zdWx0aW5nIHRoZSBpbnB1dA0KPj4+PiBzdHJ1Y3QgY3Blcl9zZWNf
bWVtX2VyciByZWNvcmQuwqAgU28gY2hhbmdlIHRvIHJlbHkgb24gaGFyZHdhcmUgd2hlbmV2ZXIN
Cj4+Pj4gc3VwcG9ydCBpcyBhdmFpbGFibGUuDQo+Pj4+DQo+Pj4+IExpbms6IA0KPj4+PiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzdlZDUwZmQ4LTUyMWUtY2FkZS03N2IxLTczOGI4YmZiODUw
MkBvcmFjbGUuY29tIA0KPj4+Pg0KPj4+Pg0KPj4+PiBSZXZpZXdlZC1ieTogRGFuIFdpbGxpYW1z
IDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEphbmUgQ2h1
IDxqYW5lLmNodUBvcmFjbGUuY29tPg0KPj4+PiAtLS0NCj4+Pj4gwqAgYXJjaC94ODYva2VybmVs
L2NwdS9tY2UvYXBlaS5jIHwgMTQgKysrKysrKysrKysrKy0NCj4+Pj4gwqAgMSBmaWxlIGNoYW5n
ZWQsIDEzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FwZWkuYyANCj4+Pj4gYi9hcmNoL3g4Ni9rZXJu
ZWwvY3B1L21jZS9hcGVpLmMNCj4+Pj4gaW5kZXggNzE3MTkyOTE1ZjI4Li4yNmQ2MzgxOGIyZGUg
MTAwNjQ0DQo+Pj4+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FwZWkuYw0KPj4+PiAr
KysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9hcGVpLmMNCj4+Pj4gQEAgLTI5LDE1ICsyOSwy
NyBAQA0KPj4+PiDCoCB2b2lkIGFwZWlfbWNlX3JlcG9ydF9tZW1fZXJyb3IoaW50IHNldmVyaXR5
LCBzdHJ1Y3QgDQo+Pj4+IGNwZXJfc2VjX21lbV9lcnIgKm1lbV9lcnIpDQo+Pj4+IMKgIHsNCj4+
Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgbWNlIG07DQo+Pj4+ICvCoMKgwqAgaW50IGdyYWluID0gUEFH
RV9TSElGVDsNCj4+Pj4gwqDCoMKgwqDCoCBpZiAoIShtZW1fZXJyLT52YWxpZGF0aW9uX2JpdHMg
JiBDUEVSX01FTV9WQUxJRF9QQSkpDQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+
Pj4+ICvCoMKgwqAgLyoNCj4+Pj4gK8KgwqDCoMKgICogRXZlbiBpZiB0aGUgLT52YWxpZGF0aW9u
X2JpdHMgYXJlIHNldCBmb3IgYWRkcmVzcyBtYXNrLA0KPj4+PiArwqDCoMKgwqAgKiB0byBiZSBl
eHRyYSBzYWZlLCBjaGVjayBhbmQgcmVqZWN0IGFuIGVycm9yIHJhZGl1cyAnMCcsDQo+Pj4+ICvC
oMKgwqDCoCAqIGFuZCBmYWxsYmFjayB0byB0aGUgZGVmYXVsdCBwYWdlIHNpemUuDQo+Pj4+ICvC
oMKgwqDCoCAqLw0KPj4+PiArwqDCoMKgIGlmIChtZW1fZXJyLT52YWxpZGF0aW9uX2JpdHMgJiBD
UEVSX01FTV9WQUxJRF9QQV9NQVNLKSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBncmFpbiA9IH5t
ZW1fZXJyLT5waHlzaWNhbF9hZGRyX21hc2sgKyAxOw0KPj4+PiArwqDCoMKgwqDCoMKgwqAgaWYg
KGdyYWluID09IDEpDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdyYWluID0gUEFHRV9T
SElGVDsNCj4+Pg0KPj4+IFdhaXQsIGlmIEBncmFpbiBpcyB0aGUgbnVtYmVyIG9mIGJpdHMgdG8g
bWFzayBvZmYgdGhlIGFkZHJlc3MsIHNob3VsZG4ndA0KPj4+IHRoaXMgYmUgc29tZXRoaW5nIGxp
a2U6DQo+Pj4NCj4+PiDCoMKgwqDCoCBncmFpbiA9IG1pbl9ub3RfemVybyhQQUdFX1NISUZULCAN
Cj4+PiBod2VpZ2h0NjQofm1lbV9lcnItPnBoeXNpY2FsX2FkZHJfbWFzaykpOw0KPj4NCj4+IEkg
c2VlLiBJIGd1ZXNzIHdoYXQgeW91IG1lYW50IGlzDQo+PiDCoMKgwqAgZ3JhaW4gPSBtaW4oUEFH
RV9TSElGVCwgKDEgKyANCj4+IGh3ZWlnaHQ2NCh+bWVtX2Vyci0+cGh5c2ljYWxfYWRkcl9tYXNr
KSkpOw0KPiANCj4gU29ycnksIHRha2UgdGhhdCBiYWNrLCBpdCB3b24ndCB3b3JrIGVpdGhlci4N
Cg0KVGhpcyB3aWxsIHdvcmssDQogICBncmFpbiA9IG1pbl9ub3RfemVybyhQQUdFX1NISUZUIC0g
MSwgDQpod2VpZ2h0NjQofm1lbV9lcnItPnBoeXNpY2FsX2FkZHJfbWFzaykpOw0KICAgZ3JhaW4r
KzsNCmJ1dCB0b28gc29waGlzdGljYXRlZD8gIEkgZ3Vlc3MgSSBwcmVmZXIgdGhlIHNpbXBsZSAi
aWYiIGV4cHJlc3Npb24uDQoNCnRoYW5rcywNCi1qYW5lDQoNCj4gDQo+IC1qYW5lDQo+IA0KPj4g
c28gdGhhdCBpbiB0aGUgcG1lbSBwb2lzb24gY2FzZSwgJ2dyYWluJyB3b3VsZCBiZSA4LCBub3Qg
Ny4NCj4+DQo+PiB0aGFua3MsDQo+PiAtamFuZQ0KPj4NCj4+Pg0KPj4+IC4uLj8NCj4+DQo+IA0K
DQo=
