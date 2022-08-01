Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2345873AC
	for <lists+linux-edac@lfdr.de>; Tue,  2 Aug 2022 00:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiHAWBq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 1 Aug 2022 18:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiHAWBp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 1 Aug 2022 18:01:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E7A2D1F8;
        Mon,  1 Aug 2022 15:01:44 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271KSl43023121;
        Mon, 1 Aug 2022 22:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=DXHMq5FEicrnjAmLfpvHhU9y9E/+xBS+n8ccGWGJq50=;
 b=X82wE3RNbp/Vr1P4mBbgyNucAhfvVXtA4X6rnaOGkP+P0q1YyCFsItwWn1DdjNTQ/m7n
 24VzPg4W5Xtib7HNyG5vFblnhjDQchzUGiVCE4t/VjlzZhqEtndc7A3UbXns8hUeWlHd
 Ijh4zOMObXfD6Ke/jhBE+Slk8xZLvssmeLWWrr7G2xo5IgCu+DKgR4xbDApMuwWM2D9g
 On+fBI/lX/93PGU4VY/BbhiJ6XFNLZtXP8wUAMYn0b+6WkVstwt2x9VLoneFmGPPrSld
 /kjwVi6rHg0H4SnOdXMrq27SftpJjwniw8JWZ+PJ87VH9+wTu+ClU9MOgY7XHkV2PmxM 0A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu80w3bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 22:01:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 271Kdd4j001200;
        Mon, 1 Aug 2022 22:01:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hp57qm4yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 22:01:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsoVOsHaNqUe4DO50DUqTzuZ2ELqx+B6fPRWkmAtouHWfDiABXhwd72T0YKPWtT9qloLrRWn6ZvYNZMbpzB+rXc7O9yHuqtydbkxOxiA4YI8tcMic6DqzKyzUKVqR28e7sepClfS6JRUntxuac1OKXJ/lvBnxPGOrUQaPanxP8UVe0h0zd19rKPPDZekX1QGBprkSPpstkigvIMf2DcWwPF0SC5AEkWLyjIY5xCWECUQz3OwwvRrXJdhYgZe7XsW+oXGS7Px/Y1h8VuGba8nI+MC9Am61mRAFp5jg2a1c5BcwWwVAcbLNV7JDdqotdAgPhGqBxdVDekzutZgt5XtGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXHMq5FEicrnjAmLfpvHhU9y9E/+xBS+n8ccGWGJq50=;
 b=Db8hssU0X+oXIVfWzh5u0eFW0KuOJ4DPEy5wypesDALVXfHLytgLNqiV+TVIIwyXl0haXCe4sRXOfPbe4FovJfSXA7/8u0qkNu6qh4SM2Oe5z/Bqw/9QbQIvB/KH6jNBGjIiR8TJB/Fm07Nz7w/ZttLHXgoBZLdNVtnabPm+A6egfu3jhMHfqJvdjDryZPija1LMhRjtxZYKMQ4DRD9Nx7EMn2XcnTQiPhIU49Bijr/1sjLMuFkkSFcjf63Abh05Y/jpNjL74vV5AJ0OC/1OsPZTCf2p/bSIkAptvq1bSr5XOaKcXWQZMSidgMH1l/AAziKzVVF0Kn1fkhp1NdZPsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXHMq5FEicrnjAmLfpvHhU9y9E/+xBS+n8ccGWGJq50=;
 b=ALKUQKwZXsQcWDpf3Wd8i1M97rKwPj7Plc+vRId/k6bQMSBzNsspodDI1aTbjFijoshM5HMj0eiqs0L5T3Q8cmMl13qASR5DDEf0oNXJcStKyBHRfKUtp4lpsZny8QWHCnRQq3veEyBFTM/EtEhybnOYWyNPE+7u2pit1BPpy2A=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CY4PR1001MB2280.namprd10.prod.outlook.com (2603:10b6:910:3f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Mon, 1 Aug
 2022 22:01:13 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112%9]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 22:01:13 +0000
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
Subject: Re: [PATCH v5] x86/mce: retrieve poison range from hardware
Thread-Topic: [PATCH v5] x86/mce: retrieve poison range from hardware
Thread-Index: AQHYo9wls6kiGpcxYkOd5j6I+plua62aREeAgABAFwCAAA0CgIAAC1QA
Date:   Mon, 1 Aug 2022 22:01:13 +0000
Message-ID: <c3b1560a-73e7-c8d5-fa1a-e21efe1ffca3@oracle.com>
References: <20220730061757.3441537-1-jane.chu@oracle.com>
 <62e802fb22f2f_b075294a8@dwillia2-xfh.jf.intel.com.notmuch>
 <e3234907-df27-f0d4-ef63-ee1ec9808f54@oracle.com>
 <62e843a6ecf08_304402944b@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <62e843a6ecf08_304402944b@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3786c3a4-d3fd-403f-dad5-08da74095975
x-ms-traffictypediagnostic: CY4PR1001MB2280:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rSxknJrMivdeo4R7gHcC+qo8SrqMCzzvkyCn3m70Lk97CdUZ5wDYb48P6YQ0oQXTLm8GeadtKazIuBBSQZYeb+YG2ccXuW6DDWPgNhZG9oXZBxbazQFMOXdOKfe2EnaMLa9ltDzF8dFoNaDeYbk3LlawBCa6xwWncmhrMRWZmtMiZUb5o8Piofiub49VIhdhxFKo37fuYXSj25iaTFGmRwo4R6a9TmBBsGb/Xl8rGrsxfU+0kIOHO7rqoLl7g/P2S2RYid7zKoycK/RQIorvvFCSrP7pNppEcex56DR5eox16zw/+Nv+TEnY7tE3OwIKuzNRCTp/wsTSz29LDnX2egiSASW8FXBGjIx7P/9IKHu9Q7xKubqMdh6zJPdotpurN20dGp0N+8p3ro8+rbHNk72UGpytJuGU5xxWJRrLA8xt5AtzyYnXBnNS5HShp3L8QyjoYtnBbHDjNrzxXCEI0996EdyC718RMVvF1wr3Bs3t5T1pJWCOXoAekj5IKhKz0dJbEY5bRylo86vCiA4CwP0GVDxRmGKGM6jzVrkuLnzFvx5MfyJZhudO73dyGLe7e4DHvuvV6r95fsFdYaOTSwwZnVtYupbmzbw9PXjDC8sNwx9cp6s5HKYkj9j/Vg9gXoof4CcZwFPkaGZluPFaURbqEaUbs/6miEsP6RBXh17wZ1GdtCllALsJvcdHW3Hi1krFGlmaJk5wOR2M7L0ArSR/AE5FO2LLANz4Hxp0fCwuFwp9znmC2x4e6alsDBGNP6IDAaVSPIC873dfViK5Ks00sUz7/XAweR6axHL8w8ESY7eoNJsp/URAPdgdJwjm/DjoxeatL8J6OVRByECEX7kE4P4R/wejoJA1o9dgleADGD0M+yFgA0vKNRfbx5ItQP4mIjk/LAGcxshfphJFLA1wu/P3zEMlRW0OBpQYut0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(396003)(366004)(376002)(39860400002)(53546011)(71200400001)(186003)(6512007)(2616005)(6486002)(41300700001)(966005)(38070700005)(478600001)(921005)(7416002)(36756003)(31686004)(8936002)(6506007)(44832011)(110136005)(26005)(2906002)(66476007)(38100700002)(66446008)(83380400001)(316002)(122000001)(64756008)(31696002)(66556008)(76116006)(86362001)(8676002)(5660300002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ulg2TC9qaUw4aWlsUmU2MjVUQWVtcXAxc2x5azA0M01EbHdxSUVYb2tkU2FR?=
 =?utf-8?B?THZKb3JUazUzTzVkUlJhbWY5ZG5LMjh1UnBZeCt3elZDdE1xeW9veHZwanpi?=
 =?utf-8?B?SFJNNDBQWFU5dVl0ZW9RUW5EQVZCekFXWEZhaS9hSDVyV1pRTitmaUdtSWUy?=
 =?utf-8?B?UXhnLzBpcGxxV21saG5Ub0NEYjRTdVUwdzllT2hmZEk0RVFPU1VkcEFoYlhT?=
 =?utf-8?B?eWxFeVB2dDdXMDd0ZitpeCtIMEJ4ck5LTnc5SnBEcUdKekZJbHlmeC95bEo5?=
 =?utf-8?B?VjRweW5kZ3FDK2lQWDgyZDc5eko4bWw4RG5iOFhXWCttZHBYRE1mQnJILytS?=
 =?utf-8?B?WnpyRWpCdFlkTlZMajlKLzBjRDVWMWw0MlFFVlFubExJeXorZlZ5Tll3b1RJ?=
 =?utf-8?B?MTFiWDJUeFZJbDJtWmtpK1AyK2ZMS2p3OEFxQzFBQzdYdXhaRnRrRUxoZWNO?=
 =?utf-8?B?dkJPV012UUN2dVlaSmNoU2VnUUhrTGxQSjJucWhFZUQxNkMrd3pOUUZuN0c3?=
 =?utf-8?B?dUo2RnZ5amFuMEFvaE9vL1ZKL1NhUFkwTUFUclM4VzJMbWc5VTNTRkpMMngx?=
 =?utf-8?B?TC9XWElPeDBRNTBOV3NCQ0w1YWxIMXI0MlVPM2FPVXZLUkVKdDRBNVZHVUNM?=
 =?utf-8?B?a0pqcUFLeGJZQlRvcmt5ZXVUWkFCdzlsWVJTeElxT21XNkpsaGdNbHdNcXJZ?=
 =?utf-8?B?K3k4b1R1b2xIb1ArUFVTc3dXYkE1VlZmK0VxZmRkaE5Sd0Z0MVdPSXVIOUlS?=
 =?utf-8?B?Ni9sUU82R0NIMnlpMWV2NVpQakkvYUpITjFxU1kxeDc1ZDd4Q3ovSnhSeGh0?=
 =?utf-8?B?YUlNdU5BVDdLL1UrUG9Ed25KWmo0eVhDVXdjaTVtZkQ4NmlieUFJT0I1dWg5?=
 =?utf-8?B?djRSZkcyQllmdHdGaFpYV3JaeFk3RENJM1pDRDlJbkJxL0lWVmZWT3NaWnlp?=
 =?utf-8?B?NEVvc0dJRVVQZW1QUWlLT1FPYitYQkhIeXRTUmR2STF1bmZRMTdETUk3VEJI?=
 =?utf-8?B?VktCeWFpU2RaNWRJa3BzSmFMYnFGZzNKUU5CTXhYTDJCRm5CbmRSN3g1a1FW?=
 =?utf-8?B?bzNGTkRCdnZQQ2hLTjZiWmNFc2NzQmk0L0lXVjhIdnBWNy9tMEdsMWxFVWJU?=
 =?utf-8?B?d2phTkJMR1Y0dzJidHhJa1ltamVmK1RJMVI0SHpNYWljdVpQTEtlcm41Ky9y?=
 =?utf-8?B?U3ZmVUlaaythZXVQRlFzbm8zSkVTV2JlR3BFbnNEVm9JdmhCZTFGVEZwcG8w?=
 =?utf-8?B?QncrbVNITG9UMlhTZEhuR0xjWXdpT2FTaGpFdU5jWXgyQnI3Y3oreEVaSzFi?=
 =?utf-8?B?bVg4NW1jREdJa2NhS3VpeWU3eHk3RHBqQUEybWhyTmV1ZW1CWkVWRFFyVHRD?=
 =?utf-8?B?cEgzRDNkYTVURzJjVno0Vk1KY0k2TU16RXBxSGhmcEhmTWxDbmFtQTl1dk1D?=
 =?utf-8?B?bWgzSWlqbFVjWHRRMlNXWjYrMU1JejdFcjg2VjVvNXRhNnBpQ1J0ZGFjdTBP?=
 =?utf-8?B?S1dDVld0R2x6RUw0SlVMMW5kRjlFTm1WL004NWJhQUlkdE80S2FkU1Q3NWFR?=
 =?utf-8?B?b0Q3cDBPMmJjQWhodXZCKzdzeXhPYVJHcG10Vk5TU29sL3pqc0ZscmZEcTRr?=
 =?utf-8?B?QUpEdnd6ejl1MytZOWRQSHR5Nmg3YnNuT0JZdU5rbmZwSFdzcDZjY2hySzN1?=
 =?utf-8?B?Ny8yZ1NEOTJLMC9pSE50enNncUoyczhZYnJmMEdhVXNRK3hmK3FvcGR6WHg3?=
 =?utf-8?B?VjFpbDlKZVZPc1NVWVRYOWUyYWl4WGcxL05FeE5Kd3AzVTJCU1dvUUxDaVNm?=
 =?utf-8?B?QnNPY1ZaUE93ZmlCVkxSN01IdUtBbG51dVFWSTJTTHl4SG50N2FqQlcyb0tG?=
 =?utf-8?B?M1dWRVc0Q2o1ZVVDY25BcGVSalY2OExQWStHK0ZRWEFNSU4xZWxZZ3pZR0xa?=
 =?utf-8?B?SFVhWkF1SEJ4VXNRd3JEZEMzUjZPaUlrNm5wQXhzR1ZsYWR6c3ZDbFpCSXhw?=
 =?utf-8?B?YlkzeUp3YS9UR3E0dVhKdUFYb25hSDJTUWUyaVl2LzQxYkRiSUtuZzlzZW1W?=
 =?utf-8?B?LzBucnZJOFdOV1BHRllING5BRjFXZENta2x0Wk1PTmZTcmkxcHdvUHpHY0lE?=
 =?utf-8?Q?xA90=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4515ED9B36C1447869852A455BE439C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3786c3a4-d3fd-403f-dad5-08da74095975
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 22:01:13.0614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oxgs1djUcIURiuzLBBHCGyKxugspLtjlPiYUv8Yl4lDSCzfRJg3yqIx+3w5xEG5FH6waa7s4a5466vmRsrOzHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2280
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_11,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010110
X-Proofpoint-ORIG-GUID: Yf7kztCYZ1LygcDbAIahVUGJiwtFsL9K
X-Proofpoint-GUID: Yf7kztCYZ1LygcDbAIahVUGJiwtFsL9K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gOC8xLzIwMjIgMjoyMCBQTSwgRGFuIFdpbGxpYW1zIHdyb3RlOg0KPiBKYW5lIENodSB3cm90
ZToNCj4+IE9uIDgvMS8yMDIyIDk6NDQgQU0sIERhbiBXaWxsaWFtcyB3cm90ZToNCj4+PiBKYW5l
IENodSB3cm90ZToNCj4+Pj4gV2l0aCBDb21taXQgNzkxN2Y5Y2RiNTAzICgiYWNwaS9uZml0OiBy
ZWx5IG9uIG1jZS0+bWlzYyB0byBkZXRlcm1pbmUNCj4+Pj4gcG9pc29uIGdyYW51bGFyaXR5Iikg
dGhhdCBjaGFuZ2VkIG5maXRfaGFuZGxlX21jZSgpIGNhbGxiYWNrIHRvIHJlcG9ydA0KPj4+PiBi
YWRyYW5nZSBhY2NvcmRpbmcgdG8gMVVMTCA8PCBNQ0lfTUlTQ19BRERSX0xTQihtY2UtPm1pc2Mp
LCBpdCdzIGJlZW4NCj4+Pj4gZGlzY292ZXJlZCB0aGF0IHRoZSBtY2UtPm1pc2MgTFNCIGZpZWxk
IGlzIDB4MTAwMCBieXRlcywgaGVuY2UgaW5qZWN0aW5nDQo+Pj4+IDIgYmFjay10by1iYWNrIHBv
aXNvbnMgYW5kIHRoZSBkcml2ZXIgZW5kcyB1cCBsb2dnaW5nIDggYmFkYmxvY2tzLA0KPj4+PiBi
ZWNhdXNlIDB4MTAwMCBieXRlcyBpcyA4IDUxMi1ieXRlLg0KPj4+Pg0KPj4+PiBEYW4gV2lsbGlh
bXMgbm90aWNlZCB0aGF0IGFwZWlfbWNlX3JlcG9ydF9tZW1fZXJyb3IoKSBoYXJkY29kZQ0KPj4+
PiB0aGUgTFNCIGZpZWxkIHRvIFBBR0VfU0hJRlQgaW5zdGVhZCBvZiBjb25zdWx0aW5nIHRoZSBp
bnB1dA0KPj4+PiBzdHJ1Y3QgY3Blcl9zZWNfbWVtX2VyciByZWNvcmQuICBTbyBjaGFuZ2UgdG8g
cmVseSBvbiBoYXJkd2FyZSB3aGVuZXZlcg0KPj4+PiBzdXBwb3J0IGlzIGF2YWlsYWJsZS4NCj4+
Pj4NCj4+Pj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci83ZWQ1MGZkOC01MjFlLWNh
ZGUtNzdiMS03MzhiOGJmYjg1MDJAb3JhY2xlLmNvbQ0KPj4+Pg0KPj4+PiBSZXZpZXdlZC1ieTog
RGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYt
Ynk6IEphbmUgQ2h1IDxqYW5lLmNodUBvcmFjbGUuY29tPg0KPj4+PiAtLS0NCj4+Pj4gICAgYXJj
aC94ODYva2VybmVsL2NwdS9tY2UvYXBlaS5jIHwgMTQgKysrKysrKysrKysrKy0NCj4+Pj4gICAg
MSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pj4NCj4+
Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FwZWkuYyBiL2FyY2gveDg2
L2tlcm5lbC9jcHUvbWNlL2FwZWkuYw0KPj4+PiBpbmRleCA3MTcxOTI5MTVmMjguLjJjN2VhMGJh
OWRkNyAxMDA2NDQNCj4+Pj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvYXBlaS5jDQo+
Pj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FwZWkuYw0KPj4+PiBAQCAtMjksMTUg
KzI5LDI3IEBADQo+Pj4+ICAgIHZvaWQgYXBlaV9tY2VfcmVwb3J0X21lbV9lcnJvcihpbnQgc2V2
ZXJpdHksIHN0cnVjdCBjcGVyX3NlY19tZW1fZXJyICptZW1fZXJyKQ0KPj4+PiAgICB7DQo+Pj4+
ICAgIAlzdHJ1Y3QgbWNlIG07DQo+Pj4+ICsJaW50IGxzYiA9IFBBR0VfU0hJRlQ7DQo+Pj4+ICAg
IA0KPj4+PiAgICAJaWYgKCEobWVtX2Vyci0+dmFsaWRhdGlvbl9iaXRzICYgQ1BFUl9NRU1fVkFM
SURfUEEpKQ0KPj4+PiAgICAJCXJldHVybjsNCj4+Pj4gICAgDQo+Pj4+ICsJLyoNCj4+Pj4gKwkg
KiBFdmVuIGlmIHRoZSAtPnZhbGlkYXRpb25fYml0cyBhcmUgc2V0IGZvciBhZGRyZXNzIG1hc2ss
DQo+Pj4+ICsJICogdG8gYmUgZXh0cmEgc2FmZSwgY2hlY2sgYW5kIHJlamVjdCBhbiBlcnJvciBy
YWRpdXMgJzAnLA0KPj4+PiArCSAqIGFuZCBmYWxsYmFjayB0byB0aGUgZGVmYXVsdCBwYWdlIHNp
emUuDQo+Pj4+ICsJICovDQo+Pj4+ICsJaWYgKG1lbV9lcnItPnZhbGlkYXRpb25fYml0cyAmIENQ
RVJfTUVNX1ZBTElEX1BBX01BU0spIHsNCj4+Pj4gKwkJbHNiID0gX19mZnM2NChtZW1fZXJyLT5w
aHlzaWNhbF9hZGRyX21hc2spOw0KPj4+PiArCQlpZiAobHNiID09IDEpDQo+Pj4NCj4+PiBUaGlz
IHdhcyB0aGUgcmVhc29uIEkgcmVjb21tZW5kZWQgaHdlaWdodDY0IGFuZCBtaW5fbm90X3plcm8o
KSBhcw0KPj4+IGh3ZWlnaHQ2NCBkb2VzIG5vdCBoYXZlIHRoZSB1bmRlZmluZWQgYmVoYXZpb3Iu
IEhvd2V2ZXIsIGFuIGV2ZW4gYmV0dGVyDQo+Pj4gb3B0aW9uIGlzIHRvIGp1c3QgZG86DQo+Pj4N
Cj4+PiAgICAgICBmaW5kX2ZpcnN0X2JpdCgmbWVtX2Vyci0+cGh5c2ljYWxfYWRkcl9tYXNrLCBQ
QUdFX1NISUZUKQ0KPj4+DQo+Pj4gLi4uYXMgdGhhdCB0cmltcyB0aGUgcmVzdWx0IHRvIHRoZSBQ
QUdFX1NISUZUIG1heCBhbmQgaGFuZGxlcyB0aGUgemVybw0KPj4+IGNhc2UuDQo+Pg0KPj4gVGhh
bmtzIERhbiEgIEhvd2V2ZXIgaXQgbG9va3MgbGlrZSBmaW5kX2ZpcnN0X2JpdCgpIGNvdWxkIGNh
bGwgaW50bw0KPj4gX19mZnMoeCkgd2hpY2ggaGFzIHRoZSBzYW1lIGxpbWl0YXRpb24gYXMgX19m
ZnM2NCh4KSwgYXMgVG9ueSBwb2ludGVkIG91dC4NCj4gDQo+IE5vdCBxdWl0ZSwgbm8uIF9fZmZz
KCkgYmVoYXZpb3IgaXMgKnVuZGVmaW5lZCogaWYgdGhlIGlucHV0IGlzIHplcm8uDQo+IGZpbmRf
Zmlyc3RfYml0KCkgaXMgKmRlZmluZWQqIGFuZCByZXR1cm5zIEBzaXplIGlzIHRoZSBpbnB1dCBp
cyB6ZXJvLg0KPiBXaGljaCBpcyB0aGUgYmVoYXZpb3IgdGhpcyB3YW50cyB0byBkZWZhdWx0IHRv
IFBBR0VfU0hJRlQgaW4gdGhlIGFic2VuY2UNCj4gb2YgYW55IHNtYWxsZXIgZ3JhbnVsYXJpdHkg
aW5mb3JtYXRpb24uDQo+IA0KDQpZb3UncmUgcmlnaHQsIGJlY2F1c2Ugb2YgdGhpcyBsaW5lIC0N
CiAgICByZXR1cm4gdmFsID8gX19mZnModmFsKSA6IHNpemU7DQoNClRoYW5rcyENCi1qYW5lDQoN
Cg0K
